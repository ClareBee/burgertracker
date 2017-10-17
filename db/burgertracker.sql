DROP TABLE applyingdeals;
DROP TABLE deals;
DROP TABLE burgers;
DROP TABLE restaurants;

CREATE TABLE restaurants
(
  id SERIAL8 primary key,
  name VARCHAR(255) not null,
  location VARCHAR(255),
  rating INT
);

CREATE TABLE burgers
(
  id SERIAL8 primary key,
  restaurant_id INT8 references restaurants(id) ON DELETE CASCADE,
  name VARCHAR(255),
  price NUMERIC(5, 2),
  veg BOOLEAN
);

CREATE TABLE deals
(
  id SERIAL8 primary key,
  restaurant_id INT8 references restaurants(id) ON DELETE CASCADE,
  name VARCHAR(255),
  discount NUMERIC(5, 2),
  day VARCHAR(255)
);

CREATE TABLE applyingdeals
(
  id SERIAL8 primary key,
  deal_id INT8 references deals(id) ON DELETE CASCADE,
  burger_id INT8 references burgers(id) ON DELETE CASCADE
);
