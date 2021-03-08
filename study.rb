require 'sqlite3'

class Study
  attr_accessor :title, :category

  def self.connection
    db = SQLite3::Database.open("study_diary.db")
    r = yield db
    db.close
    return r
  end

  def self.count(term)
    result = self.connection do |db|
      wildcard_term = "%#{term}%"
      db.execute("SELECT count() FROM study_items WHERE title LIKE ? OR category LIKE ?", [wildcard_term, wildcard_term])
    end

    if result.length > 0
      puts "*********************************************************************" 
      puts "# O total de itens que correspondem à pesquisa é #{result[0]}"
      puts "*********************************************************************"
    else
      nil
    end
  end

  def self.find(term)
    result = self.connection do |db|
      wildcard_term = "%#{term}%"
      db.execute("SELECT * FROM study_items WHERE title LIKE ? OR category LIKE ?" , [wildcard_term, wildcard_term])
    end

    if result.length > 0
      result.each do |item|
        puts "*********************************************************************" 
        puts "##{item[0]} title: #{item[1]}         category: #{item[2]}"
        puts "*********************************************************************"
      end
    else
      nil
    end
  end

  def self.delete(item_id)
    result = self.connection do |db|
      db.execute("DELETE FROM study_items WHERE id = ? " , [item_id])
    end

    if result.length > 0
      puts "*********************************************************************" 
      puts "#Item de estudo id#{item_id} deletado com sucesso"
      puts "*********************************************************************"
    else
      nil
    end
  end

  def self.all
    result = self.connection do |db|
      db.execute("SELECT * FROM study_items")
    end

    if result.length > 0
      result.each do |item|
        puts "*********************************************************************" 
        puts "##{item[0]} title: #{item[1]}         category: #{item[2]}"
        puts "*********************************************************************"
      end
    else
      nil
    end
  end

  def self.register
    params = {}
    puts 'Digite o título do seu item de estudo: '
    params[:title] = gets.chomp
    puts 'Digite a categoria do seu item de estudo: '
    params[:category] = gets.chomp
    result = self.connection do |db|
      db.execute("INSERT INTO study_items(title, category) VALUES(?, ?)", [params[:title], params[:category]])
    end
    puts "Item '#{params[:title]}' da categoria '#{params[:category]}' cadastrado com sucesso!"
    self.new params
  end 

  def initialize(params)
    @title = params[:title]
    @category = params[:category]
  end
end


