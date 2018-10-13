class Item
  def initialize(price, name, quantity)
    @price = Float(price)
    @name = name
    @quantity = Integer(quantity)
  end
  attr_accessor :quantity
end