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
    invoices_on(date)
  end

  def favorite_customer
    grouped_invoices_by_customer.max_by do |customer, invoices|
      invoices.count
    end.first
  end

  def customers_with_pending_invoices
    pending_invoices.map(&:customer)
  end

  private

  def pending_invoices
    invoices.select(&:pending?)
  end

  def successful_invoices
    invoices.reject(&:pending?)
  end

  def grouped_invoices_by_customer
    successful_invoices.group_by(&:customer)
  end
end
