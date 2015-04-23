require_relative "model"

class InvoiceItem < Model
  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at
end
