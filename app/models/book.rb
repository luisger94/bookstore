class Book < ActiveRecord::Base
	belongs_to :author
	has_and_belongs_to_many :categories
	
	validates :title, presence: true, length: { maximum: 25, message: "can not be longer that 25 characters."}
	validates :description, presence: {message: "of the book is required."}, length: { in: 2..100, message: "must be between 2 and 100 characters."}
	

 
  # It returns the books whose titles contain one or more words that form the query
  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("title like ? OR description like ?", "%#{query}%", "%#{query}%")
  end

  def author_name
		author.name
	end

	def categories=(cats)
		# in case no category was checked, erase any categories already assigned
		if cats.blank?
			self.categories.delete_all
		else
			# save the checked categories
  		cats.split(",").each do |cat|
  			# load the category
  			category = Category.find_by(id: cat)
  			# check if this book already belongs to this category
  			unless self.categories.include?(category)
		      self.categories << category
		    end
		  end
		end
	end

	def categories_array
		self.categories.pluck(:name).join(", ")
	end

	def has_category?(cat)
		self.categories.include?(cat)
	end

end







