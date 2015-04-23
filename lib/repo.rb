class Repo
  def initialize(reader, directory, engine)
    @engine = engine
    @models = []
    @index = {}
    reader.each(csv_file, directory) do |row|
      model_type.new(row, self)
    end
  end

  def csv_file
    model_type.to_s.downcase + "s.csv"
  end

  def model_type
    nil
  end

  def all
    @models
  end

  def random
    all.sample
  end

  def find_by(attribute, value)
    all.find { |model| model.__send__(attribute) == value }
  end

  def find_all_by(attribute, value)
    all.select { |model| model.__send__(attribute) == value }
  end

  def inspect
    "#<#{self.class} #{@models.size} rows>"
  end
end
