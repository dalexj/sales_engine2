class Model
  def initialize(data, repo)
    @repo = repo
    data.each do |key, value|
      instance_variable_set "@#{key}", value
    end
  end
end
