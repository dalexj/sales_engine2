require_relative "model"

class Item < Model
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at
end
