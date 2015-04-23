require_relative "model"

class Customer < Model
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at
end
