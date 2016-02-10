module BooksHelper

	def authors_array
		Author.all.map {|a| [a.name, a.id]}
	end

end
