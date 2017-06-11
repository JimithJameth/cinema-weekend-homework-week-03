require_relative("../db/sql_runner")
require('pry')

class Ticket

  attr_reader :id
  attr_accessor :name_id , :film_id

  def initialize(options)

    @id = options["id"].to_i
    @customer_id = options["customer_id"].to_i
    @film_id = options["film_id"].to_i
  end

  def save()
    sql = "INSERT INTO tickets(
    customer_id,
    film_id
    ) VALUES (
    #{@customer_id},
    #{@film_id}
    ) RETURNING *"
    tickets = SqlRunner.run(sql)
    @id = tickets[0]["id"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    SqlRunner.run(sql)
    ticket_hashes = SqlRunner.run(sql)
    return ticket_hashes.map{|ticket_hash| Ticket.new(ticket_hash)}
  end

  def update
    sql "UPDATE tickets SET (
    name_id,
    film_id,
    ) = (
    #{@name_id},
    #{@film_id}
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def delete
    sql ="DELETE FROM tickets WHERE id = #{@id}"
    SqlRunner.run(sql)
  end


end