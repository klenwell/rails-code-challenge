class PurchasesController < ApplicationController

  class InvalidUpload < Exception; end

  before_action :authenticate

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
      # Rescue block for file-level validations: empty file, invalid format, etc.
      begin
        SmarterCSV.process(@upload.path, {:col_sep => "\t"}).each do |row, line_num|
          # Validate header row
          # TODO: This is kludgey. Is there a way to get header row itself from SmarterCSV?
          if line_num == 0
            expected_columns = [:purchaser_name, :item_description, :item_price,
                                :purchase_count, :merchant_address, :merchant_name]
            raise InvalidUpload.new('Invalid file format.') unless
              row.keys.sort == expected_columns.sort
          end

          # Create new purchase record (along with associated merchant, product
          # purchaser records.)
          # TODO: Wrap this in a rescue so processing doesn't stop at first invalid row.
          Purchase.create_from_uploaded_row!(row)

          row[:total_amount] = row[:purchase_count].to_i * row[:item_price].to_f
          @rows[:valid] << row
        end

      # If file is invalid, rollback transactions
      rescue ActiveRecord::ActiveRecordError, InvalidUpload, ArgumentError, EOFError => e
        @rows[:invalid] << [0, nil, e]
        raise ActiveRecord::Rollback, 'Only valid files are saved.'
      end
    end
  end

end
