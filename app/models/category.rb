class Category < ActiveRecord::Base
	has_and_belongs_to_many :books

	validates :name, presence: {message: "of the category is required."}, length: {maximum: 25, message: "can not be longer that 25 characters."}


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
