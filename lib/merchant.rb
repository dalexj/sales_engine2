require_relative "model"

class Merchant < Model
  ATTRIBUTES = [:id, :name, :created_at, :updated_at]
  attr_reader *ATTRIBUTES

  def items
    @engine.item_repository.find_all_by_merchant_id(id)
  end

  def invoices
    @engine.invoice_repository.find_all_by_merchant_id(id)
  end

  def revenue(date = nil)
  end

  def favorite_customer
  end

  def customers_with_pending_invoices
  end
end
