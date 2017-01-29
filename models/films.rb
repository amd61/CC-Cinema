require_relative("../db/sql_runner")

class Film
  attr_reader :id
  attr_accessor :title
  attr_accessor :price

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ('#{ @title }', '#{ @price }') RETURNING id"
    film = SqlRunner.run( sql ).first
    @id = film['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    films = Films.get_many(sql)
    return films
  end

  def self.delete_all() 
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = #{@id};"
    films = SqlRunner.run( sql )
  end

  def update()
    sql = "UPDATE films SET ( title, price) = ('#{@title}', '#{@price}') WHERE id = #{@id};" 
    film = SqlRunner.run( sql )
    end 

  def self.get_many(sql)
    films = Sql.Runner.run(sql)
    result = films.map{|film|Films.new(film)} 
    return result
  end
end
