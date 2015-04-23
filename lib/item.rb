require_relative "model"

class Item < Model
  ATTRIBUTES = [:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at]
  attr_reader *ATTRIBUTES

  def invoice_items
    @engine.invoice_item_repository.find_all_by_item_id(id)
  end

  def merchant
    @engine.merchant_repository.find_all_by_id(merchant_id)
  end
end
