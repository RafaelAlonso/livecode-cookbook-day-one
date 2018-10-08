class View
  def ask_user_for_name
    puts "Qual o nome da sua receita?"
    name = gets.chomp
    return name
  end

  def ask_user_for_desc
    puts "Escreva a descrição da receita"
    description = gets.chomp
    return description
  end

  def ask_user_for_indice
    puts "Qual o índice da receita que você quer remover?"
    indice = gets.chomp.to_i - 1 # '3'.to_i ==> 3
    return indice
  end

  def listar(recipes)
    if recipes.empty?
      puts "Não há nenhuma receita salva ainda"
    else
      recipes.each_with_index do |recipe, indice|
        puts "#{indice + 1} - #{recipe.name}: #{recipe.description}"
      end
    end
  end
end
