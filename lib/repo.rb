class Repo
  def initialize(reader, directory, engine)
    @engine = engine
    @models = []
    # @index = Hash.new { |hash, key| hash[key] = [] }
    reader.each(csv_file, directory) do |row|
      new_model = model_type.new(row, engine)
      @models << new_model
      # index(new_model)
    end
    metaprogram_find_methods
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

  def inspect
    "#<#{self.class} #{@models.size} rows>"
  end

  def find_by(attribute, value)
    all.find { |model| model.__send__(attribute).to_s == value.to_s }
  end

  def find_all_by(attribute, value)
    all.select { |model| model.__send__(attribute).to_s == value.to_s }
  end

  def index(model)
    @index[model.id.to_s] << model
  end

  def metaprogram_find_methods
    model_type::ATTRIBUTES.each do |attr|
      define_singleton_method "find_by_#{attr}" do |value|
        find_by(attr, value)
      end

      define_singleton_method "find_all_by_#{attr}" do |value|
        find_all_by(attr, value)
      end
    end
  end
end
