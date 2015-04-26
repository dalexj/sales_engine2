require_relative "repo"
require_relative "item"

class ItemRepository < Repo
  def model_type
    Item
  end

  def csv_file
    "items.csv"
  end

  def most_items(amount)
    @models.sort_by(&:amount_sold).reverse[0, amount]
  end

  def most_revenue(amount)
    @models.sort_by(&:revenue).reverse[0, amount]
  end
end
