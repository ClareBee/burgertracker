require_relative( '../db/sql_runner' )
require_relative ('../models/restaurant')

class Burger

  attr_reader :id
  attr_accessor :restaurant_id, :name, :price, :veg

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @restaurant_id = options['restaurant_id'].to_i
    @name = options['name']
    @price = options['price']
    @veg = options['veg']
  end

  def save()
    sql = "INSERT INTO burgers
    (
      restaurant_id,
      name,
      price,
      veg
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING id;"
    values = [@restaurant_id, @name, @price, @veg]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM burgers;"
    values = []
    results = SqlRunner.run( sql, values )
    return results.map { |burger| Burger.new( burger )}
  end

  def self.delete_all()
    sql = "DELETE FROM burgers;"
    values = []
    SqlRunner.run( sql, values )
  end

  def self.delete(id)
    sql = "DELETE FROM bitings
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM burgers WHERE id = $1;"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def update()
    sql = "UPDATE burgers SET
    (
      restaurant_id,
      name,
      price,
      veg
    ) =
    ($1, $2, $3, $4)
    WHERE id = $5;"
    values = [@restaurant_id, @name, @price, @veg, @id]
    SqlRunner.run( sql, values)
  end

# why doesn't this work anymore - do i have to do a Restaurant.new here?
  def find_restaurant
    sql = "SELECT restaurants.* FROM restaurants INNER JOIN burgers ON restaurants.id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    array = results.map {|rest| Restaurant.new(rest)}
    return array
  end

  def self.find(id)
    sql = "SELECT * FROM burgers WHERE id = $1;"
    values =[id]
    results = SqlRunner.run(sql, values)
    return Burger.new(results.first)
  end





end
