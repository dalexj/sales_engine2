require_relative "repo"
require_relative "transaction"

class TransactionRepository < Repo
  def model_type
    Transaction
  end

  def csv_file
    "transactions.csv"
  end
end
