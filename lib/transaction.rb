require_relative "model"

class Transaction < Model
  ATTRIBUTES = [:id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at]
  attr_reader *ATTRIBUTES

  def invoice
    @engine.invoice_repository.find_by_id(invoice_id)
  end

  def successful?
    result == "success"
  end
end
