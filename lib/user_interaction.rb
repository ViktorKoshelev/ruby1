require_relative 'store.rb'

# base module for interaction with user
module UserInteraction
  @store = Store.new
  @value = 0

  def self.print_menu_actions
    puts '-----------Choose action-----------'
    puts '[1] Add item or book'
    puts '[2] Remove book or item'
    puts '[3] Find book by genre or name'
    puts '[4] Find item by name'
    puts '[5] Show catalog'
    puts '[6] Choose item for buying'
    puts '[7] Show shopping basket'
    puts '[8] Exit'
  end

  def self.input_action
    $stdin.gets
  end

  def self.print_item_menu(action)
    puts '[1] ' + action + ' Item'
    puts '[2] ' + action + ' Book'
  end

  def self.read_float(message)
    puts message
    Float(input_action)
  rescue StandardError
    puts 'Please enter a number(0.1 or 5)'
    read_float(message)
  end

  def self.read_string(message)
    puts message
    input_action
  end

  def self.read_attrs(attrs)
    attrs.each do |attr, type|
      attrs[attr] = if type == 'float'
                      read_float('input ' + attr.to_s)
                    else
                      read_string('input ' + attr.to_s).delete("\n")
                    end
    end
  end

  def self.add_office_item
    item = read_attrs(name: 'string')
    if @store.find_item(item)
      @store.add_office_item(item)
    else
      item2 = read_attrs(price: 'float')
      item2[:name] = item[:name]
      @store.add_office_item(item2)
    end
  end

  def self.delete_office_item
    item = read_attrs(name: 'string')
    if @store.find_item(item)
      @store.delete_office_item(item)
    else
      puts 'Error! Item not found!'
    end
  end

  def self.find_office_item
    item = read_attrs(name: 'string')
    if item = @store.find_item(item)
      puts item.to_s
    else
      puts 'Error! Item not found!'
    end
  end

  def self.add_book
    book = read_attrs(name: 'string')
    if @store.find_book_by_name(book)
      @store.add_book(book)
    else
      book2 = read_attrs(price: 'float', author: 'string', genre: 'string')
      book2[:name] = book[:name]
      @store.add_book(book2)
    end
  end

  def self.delete_book
    book = read_attrs(name: 'string')
    if @store.find_book_by_name(book)
      @store.delete_book(book)
    else
      puts 'Error! Book not found!'
    end
  end

  def self.find_book
    book = read_attrs('name or genre' => 'string')
    book[:genre] = book[:name] = book['name or genre']
    if @store.find_book_by_name(book)
      puts 'Found by name:'
      p @store.find_book_by_name(book)
    end
    if @store.find_book_by_genre(book)
      puts 'Found by genre:'
      p @store.find_book_by_genre(book)
    end
  end

  def self.choose_add(action)
    case action.to_i
    when 1
      add_office_item
    when 2
      add_book
    else
      puts 'Error!'
      puts 'Enter another action'
      add_item
    end
  end

  def self.choose_delete(action)
    case action.to_i
    when 1
      delete_office_item
    when 2
      delete_book
    else
      puts 'Error!'
      puts 'Enter another action'
      delete_item
    end
  end

  def self.add_item
    print_item_menu('Add')
    choose_add input_action
  end

  def self.delete_item
    print_item_menu('Delete')
    choose_delete input_action
  end

  def self.buy_office_item
    item = read_attrs(name: 'string')
    if @store.buy_item(item)
      puts 'Item added to basket'
    else
      puts 'Item not found'
    end
  end

  def self.buy_book
    book = read_attrs(name: 'string')
    if @store.buy_book(book)
      puts 'Book added to basket'
    else
      puts 'Book not found'
    end
  end

  def self.choose_item(action)
    case action.to_i
    when 1
      buy_office_item
    when 2
      buy_book
    else
      puts 'Error!'
      puts 'Enter another action'
      choose_item
    end
  end

  def self.buy_item
    print_item_menu('Choose')
    choose_item input_action
  end

  def self.show_basket
    puts @store.payment
  end

  def self.show_catalog
    puts @store.items
  end

  def self.choose_action(action)
    exit if action.nil?
    case action.to_i
    when 1
      add_item
    when 2
      delete_item
    when 3
      find_book
    when 4
      find_office_item
    when 5
      show_catalog
    when 6
      buy_item
    when 7
      show_basket
    when 8
      exit
    else
      puts 'Error!'
      puts 'Enter another action'
    end
    main_menu
  end

  def self.main_menu
    print_menu_actions
    choose_action input_action
  end
end
