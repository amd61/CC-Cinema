require_relative("../db/sql_runner")

class Customer
  attr_reader :id
  attr_accessor :name
  attr_accessor :funds

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{ @name }', '#{ @funds }') RETURNING id"
    user = SqlRunner.run( sql ).first
    @id = user['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    customers = Customers.get_many(sql)
    return customers
  end

  def self.delete_all() 
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = #{@id};"
    customers = SqlRunner.run( sql )
  end

  def update()
    sql = "UPDATE customers SET ( name, funds) = ('#{@name}', '#{@funds}') WHERE id = #{@id};" 
    customer = SqlRunner.run( sql )
    end 

  def self.get_many(sql)
    customers = Sql.Runner.run(sql)
    result = customers.map{|customer|Customers.new(customer)} 
    return result
  end
end
