class User < ActiveRecord::Base

	validates :email, presence: true, uniqueness: true

	def self.register_user(name, email, password)
		u = User.new(name: name, email: email, confirmed: false)
		# first, make sure this email is not already registered
		if u.valid?
			# save the user and the password
			u.set_password(password)

			# send a confirmation email to the user
			SystemMailer.activate_your_account(u).deliver_now
		else
			# there are some errors
			logger.info("\n\n ^^^^ Errors: #{u.errors.full_messages.inspect} \n\n")

			return false
		end
	end

	def self.authenticate(email, password)
		# first check if this email is registered
		u = User.find_by(email: email)

		# for a valid user, check that the entered password is correct
		if u
			# make sure that encrypting the entered password equals 
			# the hashed_password saved in the database
			if u.encrypt_password(password) == u.hashed_password
				# return the user so that in the controller we can
				# get the user id and save it in the session as the logged in user
				return u
			end
		end
		false
	end

	def authenticate(pass)
		self.encrypt_password(pass) == self.hashed_password
	end

	def alternate_name
		self.encrypt_password
	end

	def set_password(pass)
		logger.info("\n\n ^^^^ Setting the password to: #{pass.inspect} \n\n")
		hashed_password = encrypt_password(pass)
		# don't forget to save the encrypted password
		save
	end

	def encrypt_password(pass)
		# we're using the SHA1 to get a digital signature from the user's password 
		# and store this into the database
		Digest::SHA1.hexdigest(pass)
	end

	def make_admin
		self.update(website_admin: true)
	end

	def remove_admin
		self.update(website_admin: false)
	end

	def confirmed?
		self.confirmed == true
	end

	def confirm_account
		self.update(confirmed: true)
	end

end
