class Book < ActiveRecord::Base
	belongs_to :author

	validates :author_id, presence: {message: "Author is required"}
	validates :title, presence: true

def author_name
		author.name	
	end


end



