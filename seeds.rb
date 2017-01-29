require_relative( 'models/customer' )
require_relative( 'models/films' )
require_relative( 'models/ticket' )

require( 'pry-byebug' )

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({ 'name' => 'Robert Carlyle', 'funds' => 20.00 })
customer1.save()
customer1.name = 'Donald Trump'
customer1.update()
customer2 = Customer.new({ 'name' => 'Ewan McGregor', 'funds' => 5.00 })
customer2.save()

film1 = Film.new({'title' => 'Trainspotting 2', 'price' => 10.50})
film1.save()
film1.price = 15.00
film1.update()
film2 = Film.new({'title' => 'La La Land', 'price' => 7.10})
film2.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

ticket1.delete()

ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id})
ticket2.save()

ticket2.customer_id = customer1.id
ticket2.update()

def buy_ticket(our_customer, our_film)
  ticket3 = Ticket.new({ 'customer_id' => our_customer.id, 'film_id' => our_film.id})
  our_customer.funds = our_customer.funds - our_film.price
  our_customer.update()
  ticket3.save()
end

def number_tickets_bought(our_customer)
  number = Ticket.tickets_for_customer(our_customer.id)
  return number
end

def number_customers_for(our_film)
  number = Ticket.customers_for_film(our_film.id)
  return number
end

buy_ticket(customer1, film2)
numBought = number_tickets_bought(customer1)
puts  "#{numBought} tickets bought by customer 1"

numBought = number_tickets_bought(customer2)
puts  "#{numBought} tickets bought by customer 2"

numGuests = number_customers_for(film1)
puts  "#{numGuests} tickets bought for film 1"

numGuests = number_customers_for(film2)
puts  "#{numGuests} tickets bought for film 2"


binding.pry
nil