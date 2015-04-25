require_relative "repo"
require_relative "merchant"

class MerchantRepository < Repo
  def model_type
    Merchant
  end

  def csv_file
    "merchants.csv"
  end

  def revenue(date = nil)
    @models.reduce(0) { |sum, merchant| sum + merchant.revenue(date) }
  end

  def most_items(amount)
    @models.sort_by(&:items_sold).reverse[0, amount]
  end

  def most_revenue(amount)
    @models.sort_by(&:revenue).reverse[0, amount]
  end
end
