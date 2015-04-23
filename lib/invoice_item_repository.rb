require_relative "invoice_item"
require_relative "repo"

class InvoiceItemRepository < Repo
  def model_type
    InvoiceItem
  end

  def csv_file
    "invoice_items.csv"
  end
end
