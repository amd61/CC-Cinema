require_relative("../db/sql_runner")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id 

  def initialize( options )
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id)
           VALUES ('#{ @customer_id }', '#{ @film_id }') RETURNING id"
    film = SqlRunner.run( sql ).first
    @id = film['id'].to_i
  end

  def update()
    sql = "UPDATE tickets SET ( customer_id, film_id) = ('#{@customer_id}', '#{@film_id}') WHERE id = #{@id};" 
    tickets = SqlRunner.run( sql )
    end 

  def self.all()
    sql = "SELECT * FROM tickets"
    films = Ticket.get_many(sql)
    return films
  end

  def self.delete_all() 
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = #{@id};"
    tickets = SqlRunner.run( sql )
  end

  def self.get_many(sql)
    ticket = SqlRunner.run(sql)
    result = tickets.map{|ticket|Ticket.new(ticket)} 
    return result
  end

  def self.tickets_for_customer(customer_id)
    sql = "SELECT * FROM tickets WHERE customer_id = #{customer_id};"
    numTickets = SqlRunner.run( sql ).to_a.count
  end

  def self.customers_for_film(film_id)
    sql = "SELECT * FROM tickets WHERE film_id = #{film_id};"
    numTickets = SqlRunner.run( sql ).to_a.count
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id=#{@customer_id};"
    customer = SqlRunner.run(sql).first
    return Location.new(customer)
  end

  def film()
    sql = "SELECT * FROM films WHERE id = {@film_id};"
    film = SqlRunner.run(sql).first
    return User.new(film)

  end
end