require_relative 'view'
require_relative 'recipe'

class Controller
  def initialize(cookbook)
    @view     = View.new
    @cookbook = cookbook
  end

  def list
    recipes = @cookbook.all
    @view.listar(recipes)
  end

  def create
    name        = @view.get_name
    description = @view.get_desc
    recipe      = Recipe.new(name, description)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    list
    unless @cookbook.all.empty?
      indice = @view.get_indice
      @cookbook.remove_recipe(indice)
    end
  end
end
