class CreateCategoriesAndBooks < ActiveRecord::Migration
  def change
    create_table :categories_and_books, id: false do |t|
      t.belongs_to :category, index: true
      t.belongs_to :book, index: true
    end

    end
end
