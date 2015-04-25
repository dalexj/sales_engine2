require_relative "model"

class Invoice < Model
  ATTRIBUTES = [:id, :customer_id, :merchant_id, :status, :created_at, :updated_at]

  attr_reader *ATTRIBUTES

  def merchant
    @engine.merchant_repository.find_by_id(merchant_id)
  end

  def invoice_items
    @engine.invoice_item_repository.find_all_by_invoice_id(id)
  end

  def items
    invoice_items.map(&:item)
  end

  def customer
    @engine.customer_repository.find_by_id(customer_id)
  end

  def transactions
    @engine.transaction_repository.find_all_by_invoice_id(id)
  end

  def pending?
    transactions.none?(&:successful?)
  end

  def revenue
    invoice_items.reduce(0) { |sum, ii| sum + ii.revenue }
  end

  def total_quantity
    invoice_items.reduce(0) { |sum, invoice_item| sum + invoice_item.quantity }
  end
end
