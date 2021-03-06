require_relative( '../db/sql_runner' )
require_relative( '../models/restaurant')
require_relative( '../models/burger')
require_relative( '../models/applyingdeal')



class Deal

  attr_reader :id
  attr_accessor :restaurant_id, :name, :discount, :day, :savings, :new_price

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @restaurant_id = options['restaurant_id'].to_i
    @name = options['name']
    @discount = options['discount']
    @day = options['day']
  end

  def save()
    sql = "INSERT INTO deals
    (
      restaurant_id,
      name,
      discount,
      day
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING id;"
    values = [@restaurant_id, @name, @discount, @day]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM deals;"
    values = []
    results = SqlRunner.run( sql, values )
    return results.map { |deal| Deal.new( deal )}
  end

  def self.delete_all()
    sql = "DELETE FROM deals;"
    values = []
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM deals WHERE id = $1;"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def update()
    sql = "UPDATE deals SET
    (
      restaurant_id,
      name,
      discount,
      day
    ) =
    ($1, $2, $3, $4)
    WHERE id = $5;"
    values = [@restaurant_id, @name, @discount, @day, @id]
    SqlRunner.run( sql, values )
  end

  def self.find(id)
    sql = "SELECT * FROM deals WHERE id = $1;"
    values =[id]
    results = SqlRunner.run(sql, values)
    return Deal.new(results.first)
  end

  def self.list(day)
    sql = "SELECT * FROM deals WHERE day = $1;"
    values = [day]
    results = SqlRunner.run( sql, values )
    array = results.map {|name| name['name'] }
    return array.join(", ")
  end

  def restaurant()
    sql = "SELECT restaurants.* FROM restaurants WHERE restaurants.id = $1;"
    values =[@restaurant_id]
    results = SqlRunner.run( sql, values )
    return Restaurant.new(results.first)
  end

  def self.restaurant()
    sql = "SELECT restaurants.* FROM restaurants WHERE restaurants.id = $1;"
    values =[@restaurant_id]
    results = SqlRunner.run( sql, values )
    return Restaurant.new(results.first)
  end

  def find_burgers()
    sql = "SELECT * FROM burgers INNER JOIN applyingdeals on burgers.id = applyingdeals.burger_id WHERE applyingdeals.deal_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    array = results.map {|name| Burger.new(name)}
    return array
  end

  def find_applying_deal
    sql = "SELECT applyingdeals.* FROM applyingdeals INNER JOIN burgers ON applyingdeals.burger_id = burgers.id WHERE applyingdeals.deal_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return ApplyingDeal.new(results.first)
  end

end
