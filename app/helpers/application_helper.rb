module ApplicationHelper

	def confirmed_account?
		logged_in_user and logged_in_user.confirmed?
	end

end
