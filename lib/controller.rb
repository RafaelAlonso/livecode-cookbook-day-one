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
    name        = @view.ask_user_for_name
    description = @view.ask_user_for_desc
    recipe      = Recipe.new(name, description)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    list
    unless @cookbook.all.empty?
      indice = @view.ask_user_for_indice
      @cookbook.remove_recipe(indice)
    end
  end
end
