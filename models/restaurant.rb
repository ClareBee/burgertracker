require_relative( '../db/sql_runner' )
require_relative( '../models/burger')


class Restaurant

  attr_reader :id
  attr_accessor :name, :location, :rating

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @location = options['location']
    @rating = options['rating'].to_i
  end

  def save()
    sql = "INSERT INTO restaurants
    (
      name,
      location,
      rating
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id;"
    values = [@name, @location, @rating]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.find( id )
    sql = "SELECT * FROM restaurants
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Restaurant.new( results.first )
  end

  def self.all()
    sql = "SELECT * FROM restaurants;"
    values = []
    results = SqlRunner.run( sql, values )
    return results.map { |restaurant| Restaurant.new( restaurant )}
  end

  def self.delete_all()
    sql = "DELETE FROM restaurants;"
    values = []
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM restaurants WHERE id = $1;"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def update()
    sql = "UPDATE restaurants SET
    (
      name,
      location,
      rating
    ) =
    ($1, $2, $3)
    WHERE id = $4;"
    values = [@name, @location, @rating, @id]
    SqlRunner.run( sql, values)
  end

  def burgers()
    sql = "SELECT * FROM burgers WHERE burgers.restaurant_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    array = results.map {|burger| Burger.new(burger)}
    return array
  end

  def deals()
    sql = "SELECT * FROM deals WHERE deals.restaurant_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    array = results.map {|deal| Deal.new(deal)}
    return array
  end

end
