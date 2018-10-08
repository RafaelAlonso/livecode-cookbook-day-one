require 'csv'

class Cookbook
  def initialize(csv_file_path)
    @csv = csv_file_path
    @recipes = []

    CSV.foreach(@csv) do |row|
      name = row[0]
      desc = row[1]
      recipe = Recipe.new(name, desc)
      @recipes << recipe
    end
  end

  def all
    return @recipes
  end

  def add_recipe(recipe)
    # @recipes.push(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(indice)
    @recipes.delete_at(indice)
    save_csv
  end

  def save_csv
    CSV.open(@csv, 'wb') do |csv|
      @recipes.each do |receita|
        csv << [receita.name, receita.description]
      end
    end
  end
end
