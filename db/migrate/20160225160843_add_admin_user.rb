class AddAdminUser < ActiveRecord::Migration
  def change
  	u = User.create(email: "admin@bookstore.com", name: "Admin", website_admin: true)
  	u.set_password("testing")
  end
end
