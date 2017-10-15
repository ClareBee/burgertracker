require_relative( '../db/sql_runner' )

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
    return ApplyingDeal.new( results.first)
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

  def delete()
    sql = "DELETE FROM applyingdeals where id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end
  # def deal_name()
  #   sql = "SELECT name from deals where id = $1;"
  #   values = [@deal_id]
  #   results = SqlRunner.run(sql, values).first
  #   return results['name']
  # end


end
