class Recipe
  attr_reader :name, :description

  def initialize(name, desc)
    @name         = name
    @description  = desc
  end
end
