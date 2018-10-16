# Item base class
class Item
  include Comparable
  include Enumerable

  def initialize(hash)
    @price = Float(hash['price'] || hash[:price])
    @name = hash['name'] || hash[:name]
    @quantity = Integer(hash['quantity'] || hash[:quantity])
  end

  def to_h
    { price: @price, name: @name }
  end

  def <=>(other)
    @name <=> other.name
  end

  def each
    to_h.each yield
  end

  def to_s
    'name: ' + @name + ', price: ' + @price.to_s
  end

  attr_reader :price, :name
  attr_accessor :quantity
end
