require_relative 'item.rb'
# Book class extends Item class
class Book < Item
  def initialize(author, name, price, genre, quantity)
    super(price, name, quantity)
    @author = author
    @genre = genre
  end
  attr_reader :author, :genre
end
