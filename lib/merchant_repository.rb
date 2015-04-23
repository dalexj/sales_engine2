require_relative "repo"
require_relative "merchant"

class MerchantRepository < Repo
  def model_type
    Merchant
  end

  def csv_file
    "merchants.csv"
  end
end
