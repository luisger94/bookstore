class Author < ActiveRecord::Base
	has_many :books, dependent: :destroy
	validates :name, presence: {message: "of the author is required."}, length: {maximum: 25, message: "can not be longer that 25 characters."}, uniqueness: true
	validates :country, presence: {message: "of the author is required."}, length: {in: 3..50, message: "must be between 3 and 50 characters."}

 # It returns the authors whose names contain one or more words that form the query
  def self.search(query)
    # where(:name, query) -> This would return an exact match of the query
      where("name like ? OR country like ?", "%#{query}%", "%#{query}%")
  end


	# TODO - add here the validation that the book has a title

	def books_titles
		titles = []
		self.books.each do |book|
			titles << book.title
		end
		titles.join(", ")

	end

	def book_number
		titles = []
		self.books.each do |book|
			titles << book.title
		end
		books = Hash.new(0)
		titles.each { |b| books[b] += 1}
		return books.count
	end

end
