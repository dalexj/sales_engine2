require_relative "model"
require "bigdecimal"

class InvoiceItem < Model
  ATTRIBUTES = [:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at]
  attr_reader *ATTRIBUTES

  def item
    @engine.item_repository.find_by_id(item_id)
  end

  def invoice
    @engine.invoice_repository.find_by_id(invoice_id)
  end

  def invoice_created_at
    invoice.created_at
  end

  def successful?
    !invoice.pending?
  end

  def revenue
    BigDecimal.new(unit_price) * quantity / 100
  end
end
