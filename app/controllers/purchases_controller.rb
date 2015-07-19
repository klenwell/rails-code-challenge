class PurchasesController < ApplicationController

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

    SmarterCSV.process(@upload.path, {:col_sep => "\t"}).each_with_index do |row, line_num|
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
  end

end
