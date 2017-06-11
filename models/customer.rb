require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize (options)

    @id = options["id"].to_i
    @name = options["name"]
    @funds = options["funds"].to_f
    
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', #{@funds})RETURNING id"
    customer = SqlRunner.run(sql)[0]
    @id = customer['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end 

  def self.all()
    sql = "SELECT * from customers"
    customer_hashes = SqlRunner.run(sql)
    return customer_hashes.map{|customer_hash| Customer.new(customer_hash)}
  end

  def delete
    sql = "DELETE FROM customers WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def update
    sql = "UPDATE customers SET(
    name,
    funds
    ) = (
    '#{@name}',
    '#{@funds}'
    )WHERE id = #{@id}"
    SqlRunner.run(sql)
  end


  
end



