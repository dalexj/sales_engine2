require_relative "model"

class Merchant < Model
  attr_reader :id, :name, :created_at, :updated_at
end
