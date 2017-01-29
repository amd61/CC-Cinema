DROP TABLE customers;
DROP TABLE films;
DROP TABLE tickets;

CREATE TABLE customers
(
  id SERIAL8 primary key,
  name VARCHAR(255) not null,
  funds REAL
);

CREATE TABLE films
(
  id SERIAL8 primary key,
  title VARCHAR(255) not null,
  price REAL
);

CREATE TABLE tickets
(
  id SERIAL8 primary key,
  customer_id INT8 references customers(id),
  film_id INT8 references films(id)
);