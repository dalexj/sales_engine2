require_relative "repo"
require_relative "item"

class ItemRepository < Repo
  def model_type
    Item
  end

  def csv_file
    "items.csv"
  end
end
