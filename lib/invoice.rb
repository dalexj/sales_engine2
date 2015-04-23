require_relative "model"

class Invoice < Model
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at
end
