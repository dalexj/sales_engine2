require_relative "repo"
require_relative "invoice"

class InvoiceRepository < Repo
  def model_type
    Invoice
  end

  def csv_file
    "invoices.csv"
  end
end
