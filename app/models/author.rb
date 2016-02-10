class Author < ActiveRecord::Base
	has_many :books
	validates :name, presence: {message: "of the author is required."}
	validates :country, presence: {message: "of the author is required."}

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
