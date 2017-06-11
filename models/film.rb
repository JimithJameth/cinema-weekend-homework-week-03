require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)

    @id = options["id"].to_i
    @title = options["title"]
    @price = options["price"].to_f

  end

  def save()
    sql = "INSERT INTO films (title) VALUES ('#{@title}') RETURNING id"
    film = SqlRunner.run(sql)[0]
    @id = film ["id"].to_i 
  end

  def self.delete_all()
    sql = "DELETE from films"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * from films"
    film_hashes = SqlRunner.run(sql)
    return film_hashes.map{|film_hash| Film.new(film_hash)} #this line gets data from the database, loops through the array of hashes then creates film objects
  end

  def update
    sql = "UPDATE films SET (
    title,
    price
    ) = (
    '#{@title}',
    #{@price}
    )
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM films WHERE id = #{@id}"
    SqlRunner.run(sql)    
  end
end