require_relative 'item.rb'

# Book class extends Item class
class Book < Item
  def initialize(hash)
    super(hash)
    @author = hash['author'] || hash[:author]
    @genre = hash['genre'] || hash[:genre]
  end

  def to_h
    item = super
    item['author'] = @author
    item['genre'] = @genre
  end

  def to_s
    str = super
    str + ', author: ' + @author + ', genre: ' + @genre
  end

  attr_reader :author, :genre
end
