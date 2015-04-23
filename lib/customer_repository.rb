require_relative "repo"
require_relative "customer"

class CustomerRepository < Repo
  def model_type
    Customer
  end

  def csv_file
    "customers.csv"
  end
end
