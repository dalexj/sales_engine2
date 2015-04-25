require_relative "repo"
require_relative "invoice"

class InvoiceRepository < Repo
  def model_type
    Invoice
  end

  def csv_file
    "invoices.csv"
  end

  def create(customer:, merchant:, items:)
    raise "COMING SOON"
    Invoice.new(id: @models.count + 1, customer_id: customer.id, merchant_id: merchant.id)
    items.each do |item|
      @engine.invoice_item_repository.create(item)
    end
    [:id, :customer_id, :merchant_id, :status, :created_at, :updated_at]
  end
end
