require_relative "model"

class Customer < Model
  ATTRIBUTES = [:id, :first_name, :last_name, :created_at, :updated_at]
  attr_reader *ATTRIBUTES

  def invoices
    @engine.invoice_repository.find_all_by_customer_id(id)
  end

  def transactions
    invoices.flat_map(&:transactions)
  end
end
