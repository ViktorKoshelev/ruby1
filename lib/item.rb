# Item base class
class Item
  def initialize(price, name, quantity)
    @price = Float(price)
    @name = name
    @quantity = Integer(quantity)
  end
  attr_reader :price, :name
  attr_accessor :quantity
end
