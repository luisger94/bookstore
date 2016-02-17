class CreateBooksAndCategories < ActiveRecord::Migration
  def change
add_reference :books, :categories, index: true, foreign_key: true

    create_table :books_and_categories do |t|
    	t.belongs_to :books, index: true
    	t.belongs_to :categories, index: true
    end
  end
end
