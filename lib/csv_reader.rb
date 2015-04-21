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
    CSV.foreach(full_path, csv_options).map { |row| model.new(row.to_hash) }
  end

  def self.csv_options
    { headers: true ,header_converters: :symbol, converters: :all }
  end

  def self.find_which_object(file_name)
    models.find do |class_name|
      file_name.gsub("_", "") =~ Regexp.new(class_name.to_s, "i")
    end
  end

  def self.models
    [Customer, InvoiceItem, Invoice, Item, Merchant, Transaction]
  end
end
