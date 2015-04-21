class Model
  def initialize(data)
    data.each do |key, value|
      instance_variable_set "@#{key}", value
    end
  end
end
