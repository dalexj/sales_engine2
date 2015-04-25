class Repo
  def initialize(reader, directory, engine)
    @engine = engine
    @models = []
    @index = create_index
    reader.each(csv_file, directory) do |row|
      new_model = model_type.new(row, engine)
      @models << new_model
      index(new_model)
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
    one_from_index(attribute, value) || all.find { |model| model.__send__(attribute).to_s == value.to_s }
  end

  def find_all_by(attribute, value)
    from_index(attribute, value) || all.select { |model| model.__send__(attribute).to_s == value.to_s }
  end

  private

  def index(model)
    cols_to_index.each do |attr|
      @index[attr.to_s][model.__send__(attr)] ||= []
      @index[attr.to_s][model.__send__(attr)] << model
    end
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

  def cols_to_index
    @cols_to_index ||= model_type::ATTRIBUTES.grep /id/
  end

  def one_from_index(attribute, value)
    array = from_index(attribute, value)
    array.first if array
  end

  def from_index(attribute, value)
    if @index[attribute.to_s]
      @index[attribute.to_s][value] || []
    end
  end

  def create_index
    cols_to_index.each_with_object({}) { |col, index| index[col.to_s] = {} }
  end
end
