class PurchasesController < ApplicationController

  # GET /purchases
  def index
    # Shows upload form.
  end

  # POST /purchases/upload
  def upload
    # Processes uploaded file.
    # Validate upload present
    return redirect_to purchases_path, alert: 'Please submit a file.' if params[:upload].blank?

    @upload = params[:upload]

    # File records
    @rows = {
      valid: [],
      invalid: []
    }
  end

end
