class Repo
  def all
    @models
  end

  def random
    all.sample
  end

  def find_by(attribute)
    all[]
  end
end
