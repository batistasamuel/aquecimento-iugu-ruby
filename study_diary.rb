require 'sqlite3'
require_relative 'study_item'
require_relative 'study'

REGISTER = 1
VIEW     = 2
SEARCH   = 3
TOTAL    = 4
DELETE   = 5
EXIT     = 6

def clear
  system('clear')
end

def wait_keypress
  puts
  puts 'Pressione enter para continuar'
  gets
end

def clear_and_wait_keypress
  wait_keypress
  clear
end

def welcome
  'Bem-vindo ao Diário de Estudos, seu companheiro para estudar!'
end

def menu
  puts "[#{REGISTER}] Cadastrar um item para estudar"
  puts "[#{VIEW}] Ver todos os itens cadastrados"
  puts "[#{SEARCH}] Buscar um item de estudo"
  puts "[#{TOTAL}] Quantidade de itens de estudo para um termo de busca"
  puts "[#{DELETE}] Excluir um item de estudo"
  puts "[#{EXIT}] Sair"
  print 'Escolha uma opção: '
  gets.to_i
end

def search_items
  puts 'Digite uma palavra para procurar: '
  term = gets.chomp
  new_found_items = Study.find(term)
end

def count_items
  puts 'Digite uma palavra para procurar: '
  term = gets.chomp
  counter = Study.count(term)
end

def delete_item
  puts 'Digite o id do item de estudo que será deletado: '
  item_id = gets.chomp
  deleted_item = Study.delete(item_id)
end

clear
puts welcome
option = menu

loop do
  clear
  case option
  when REGISTER
    Study.register
  when VIEW
    Study.all
  when SEARCH
    search_items
  when TOTAL
    count_items
  when DELETE
    delete_item
  when EXIT
    clear
    puts 'Obrigado por usar o Diário de Estudos'
    break
  else
    puts 'Opção inválida'
  end
  clear_and_wait_keypress
  option = menu
end