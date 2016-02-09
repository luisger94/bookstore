class CreateAuthor < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :country
    end

    create_table :books do |t|
    	t.belong_to :author, index:true
  end
end
