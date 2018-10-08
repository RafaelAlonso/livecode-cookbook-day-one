require_relative 'view'
require_relative 'recipe'
require 'nokogiri'
require 'open-uri'

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
      indice = @view.ask_user_for_indice("remover")
      @cookbook.remove_recipe(indice)
    end
  end

  def scrape
    recipe_array = []

    # pega o ingrediente que o usuário quer importat
    ingredient = @view.ask_user_for_ingredient

    # url da página onde vamos procurar
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{ingredient}"

    # Ler a página da url passada
    html_file = open(url).read

    # Transforma o html_file num objeto Nokofiri::HTML
    # Serve para usarmos ferramentas como o .search
    html_doc = Nokogiri::HTML(html_file)

    # html_doc.search(parameters) << []
    html_doc.search('.m_contenu_resultat').first(5).each do |element|
      # A gente encontra o título no pedaço que obtivemos (element)
      recipe_name = element.search('.m_titre_resultat a').text.strip

      # A gente encontra a descrição no pedaço que obtivemos (element)
      recipe_description = element.search('.m_texte_resultat').text.strip

      # Populamos a array com uma nova Recipe, criada o name e desc
      recipe_array.push(Recipe.new(recipe_name, recipe_description))
    end

    # Mostramos as receitas que conseguimos pro usuário
    @view.listar(recipe_array)

    # Pedimos por um índice
    recipe_index = @view.ask_user_for_indice("importar")

    # Salvamos a receita do índice fornecido
    @cookbook.add_recipe(recipe_array[recipe_index])
  end
end
