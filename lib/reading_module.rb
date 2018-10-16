require 'csv'

# base module for reading data for store
module ReadingModule
  def self.read_initial_books
    books = []
    CSV.foreach('../books.csv', headers: true) do |row|
      books.push(row.to_h)
    end
    books
  end

  def self.read_initial_office_items
    office_items = []
    CSV.foreach('../office_items.csv', headers: true) do |row|
      office_items.push(row.to_h)
    end
    office_items
  end
end
