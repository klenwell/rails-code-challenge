class PurchasesController < ApplicationController

  class InvalidUpload < Exception; end

  # GET /purchases
  def index
    # Shows upload form.
  end

  # POST /purchases/upload
  def upload
    return redirect_to purchases_path, alert: 'Please submit a file.' if params[:upload].blank?

    # Processes uploaded file.
    @upload = params[:upload]

    # File records
    @rows = {
      valid: [],
      invalid: []
    }

    # Parse file. Wrap in a transaction so that records only will be saved only if all
    # records in file are valid.
    Purchase.transaction do
      # Rescue block for file-level validations: empty file
      begin
        SmarterCSV.process(@upload.path, {:col_sep => "\t"}).each_with_index do |row, line_num|
          # Validate header row
          # TODO: This is kludgey. Is there a way to get header row itself from SmarterCSV?
          if line_num == 0
            expected_columns = [:purchaser_name, :item_description, :item_price,
                                :purchase_count, :merchant_address, :merchant_name]
            raise InvalidUpload.new('Invalid file format.') unless
              row.keys.sort == expected_columns.sort
          end

          # Find or create associated model records.
          merchant = Merchant.where(name: row[:merchant_name],
                                    address: row[:merchant_address]).first_or_create

          product = Product.where(description: row[:item_description],
                                  price: row[:item_price],
                                  merchant_id: merchant.id).first_or_create

          purchaser = Purchaser.where(name: row[:purchaser_name]).first_or_create

          # Now we can create the new purchase record
          Purchase.create!(count: row[:purchase_count],
                                  merchant_id: merchant.id,
                                  product_id: product.id,
                                  purchaser_id: purchaser.id)

          row[:total_amount] = row[:purchase_count].to_i * row[:item_price].to_f
          @rows[:valid] << row
        end

      # If file is invalid, rollback transactions
      rescue InvalidUpload, EOFError => e
        @rows[:invalid] << [0, nil, e]
      end
    end
  end

end
