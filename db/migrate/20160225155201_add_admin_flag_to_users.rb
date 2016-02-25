class AddAdminFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :website_admin, :boolean
  end
end
