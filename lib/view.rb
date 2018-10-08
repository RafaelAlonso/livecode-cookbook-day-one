class View
  def ask_user_for_name
    puts "Qual o nome da sua receita?"
    gets.chomp
  end

  def ask_user_for_desc
    puts "Escreva a descrição da receita"
    gets.chomp
  end

  def ask_user_for_indice(action)
    puts "Qual o índice da receita que você quer #{action}?"
    gets.chomp.to_i - 1 # '3'.to_i ==> 3
  end

  def ask_user_for_ingredient
    puts "Qual o ingrediente que voce deseja usar?"
    gets.chomp
  end

  def listar(recipes)
    if recipes.empty?
      puts "Não há nenhuma receita salva ainda"
    else
      recipes.each_with_index do |recipe, indice|
        puts "#{indice + 1} - #{recipe.name}:"
        puts "  #{recipe.description}"
      end
    end
  end
end
