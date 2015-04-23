require_relative "invoice_item"
require_relative "transaction"
require_relative "customer"
require_relative "merchant"
require_relative "invoice"
require_relative "item"
require "csv"


module CSVReader
  def self.read_from(filename, dir = "data")
    model = match_model(filename)
    full_path = File.join(dir, filename)
    CSV.foreach(full_path, csv_options) { |row| model.new(row.to_hash) }
  end

  def self.each(filename, dir = "data")
    full_path = File.join(dir, filename)
    CSV.foreach(full_path, csv_options) { |row| model.new(row.to_hash) }
  end

  def self.csv_options
    { headers: true, header_converters: :symbol, converters: :all }
  end
end
