require_relative 'reading_module.rb'
require_relative 'item.rb'
require_relative 'book.rb'

# base class of book store
class Store
  def initialize
    @office_items = []
    @books = []
    @basket = []

    initial_books = ReadingModule.read_initial_books
    initial_office_items = ReadingModule.read_initial_office_items

    @books += initial_books
    @office_items += initial_office_items

    @books = @books.map { |book| Book.new(book) }
    @office_items = @office_items.map { |item| Item.new(item) }
  end

  def find_book_by_name(book)
    book = @books.find { |exist| exist.name == book[:name] }

    return false if book.to_s == ''

    book.to_s
  end

  def find_book_by_genre(book)
    books = @books.select { |exist| exist.genre == book[:genre] }
    result = ''
    books.each { |exist| result += exist.to_s + "\n" }
    
    return false if result.to_s == ''

    result
  end

  def add_book(book)
    book_f = find_book_by_name(book)
    if book_f
      book_c = @books.find { |exist| exist.name == book[:name] }
      book_c.quantity += 1
    else
      book['quantity'] = 1
      @books.push(Book.new(book))
    end
  end

  def delete_book(book)
    book_f = find_book_by_name(book)
    if book_f.quantity > 1
      book_f.quantity -= 1
    else
      @books.delete(book_f)
    end
  end

  def find_item(item)
    @office_items.find { |exist| exist.name == item[:name] }
  end

  def add_office_item(item)
    item_f = find_item(item)
    if item_f
      item_f.quantity += 1
    else
      item['quantity'] = 1
      @office_items.push(Item.new(item))
    end
  end

  def delete_office_item(item)
    item_f = find_item(item)
    if item_f.quantity > 1
      item_f.quantity -= 1
    else
      @office_items.delete item_f
    end
  end

  def buy_item(item)
    if find_item(item)
      @basket.push(find_item(item))
    else
      false
    end
  end

  def buy_book(book)
    if find_book_by_name(book)
      @basket.push(find_book_by_name(book))
    else
      false
    end
  end

  def payment
    payment = ''
    sum = 0

    @basket.each do |item|
      payment += item.to_s + "\n"
      sum += item.price
    end

    payment += 'Total sum: ' + sum.to_s + "\n"
  end

  def items
    items = '-----------Office items-----------' + "\n"
    @office_items.sort.each { |item| items += item.to_s + ', quantity: ' + item.quantity.to_s + "\n" }
    items += '-----------Books-----------' + "\n"
    @books.sort.each { |book| items += book.to_s + ', quantity: ' + book.quantity.to_s + "\n" }
    items
  end
end
