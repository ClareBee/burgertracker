require_relative( '../db/sql_runner' )
require_relative( '../models/deal')
require_relative( '../models/burger')
require_relative( '../models/restaurant')

class ApplyingDeal

  attr_reader :id
  attr_accessor :deal_id, :burger_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @deal_id = options['deal_id'].to_i
    @burger_id = options['burger_id'].to_i
  end

  def save()
    sql = "INSERT into applyingdeals
    (
      deal_id,
      burger_id
    )
    VALUES (
    $1, $2
    )
    RETURNING id;"
    values = [@deal_id, @burger_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE applyingdeals SET
    (deal_id,
    burger_id)
    = (
    $1, $2
    ) WHERE id = $3;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM applyingdeals;"
    values = []
    results = SqlRunner.run( sql, values )
    return results.map { |deal| ApplyingDeal.new( deal ) }
  end

  def self.delete_all()
    sql = "DELETE FROM applyingdeals;"
    values = []
    SqlRunner.run( sql, values )
  end

  def self.delete(id)
    sql = "DELETE FROM applyingdeals WHERE id = $1;"
    values = [id]
    SqlRunner.run( sql, values )
  end


  def self.find(id)
    sql = "SELECT * FROM applyingdeals WHERE id = $1;"
    values =[id]
    results = SqlRunner.run(sql, values)
    return ApplyingDeal.new(results.first)
  end


  def burger()
    sql = "SELECT * FROM burgers where id = $1;"
    values = [@burger_id]
    results = SqlRunner.run( sql, values )
    return Burger.new( results.first )
  end

  def deal()
    sql = "SELECT * FROM deals where id = $1;"
    values = [@deal_id]
    results = SqlRunner.run( sql, values )
    return Deal.new( results.first )
  end

  def restaurant()
    sql = "SELECT restaurants.name FROM restaurants INNER JOIN deals ON restaurants.id = deals.restaurant_id WHERE restaurants.id = $1;"
    values = [@restaurant_id]
    results = SqlRunner.run( sql, values )
    return results
  end

  def delete()
    sql = "DELETE FROM applyingdeals where id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def all_burgers()
    sql = "SELECT burgers.* FROM burgers WHERE burgers.id = $1;"
    values = [@burger_id]
    results = SqlRunner.run(sql, values)
    array = results.map {|every| Burger.new(every)}
    return array
  end

  def self.burgers_by_day(day)
    sql = "SELECT burgers.* FROM burgers INNER JOIN deals ON burgers.restaurant_id = deals.restaurant_id WHERE deals.day = $1;"
    values = [day]
    results = SqlRunner.run(sql, values)
    array = results.map {|every| Burger.new(every)}
    return array
  end

# why doesn't this work?
  def self.all_deals()
    sql = "SELECT deals.* FROM deals INNER JOIN burgers ON deals.restaurant_id = burgers.restaurant_id WHERE deals.id = $1;"
    values = [@deal_id]
    results = SqlRunner.run(sql, values)
    array = results.map {|every| Deal.new(every)}
    return array
  end
end
