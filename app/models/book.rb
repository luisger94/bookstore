class Book < ActiveRecord::Base
	belongs_to :author
	
	validates :title, presence: true, length: { maximum: 25, message: "can not be longer that 25 characters."}
	validates :description, presence: {message: "of the book is required."}, length: { in: 2..100, message: "must be between 2 and 100 characters."}
	

def author_name
		author.name
	end


end



