require "bigdecimal"
require_relative "model"

class Item < Model
  ATTRIBUTES = [:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at]
  attr_reader *ATTRIBUTES

  def invoice_items
    @engine.invoice_item_repository.find_all_by_item_id(id)
  end

  def merchant
    @engine.merchant_repository.find_by_id(merchant_id)
  end

  def convert_attributes
    @unit_price = BigDecimal.new(@unit_price) / 100
  end

  def best_day
    invoice_items_grouped_by_date.max_by do |date, invoices_items|
      invoice_items.reduce(0) { |sum, ii| sum + ii.quantity }
    end.first
  end

  def invoice_items_grouped_by_date
    successful_invoices_items.group_by { |ii| Date.parse(ii.invoice_created_at) }
  end

  def successful_invoices_items
    invoice_items.select(&:successful?)
  end

  def amount_sold
    successful_invoices_items.reduce(0) { |sum, ii| sum + ii.quantity }
  end

  def revenue
    successful_invoices_items.reduce(0) { |sum, ii| sum + ii.revenue }
  end
end
