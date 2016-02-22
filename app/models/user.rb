class User < ActiveRecord::Base

	validates :email, presence: true

	def self.register_user(name, email, password)
		logger.info("\n\n ^^^^ Registering user with email: #{email.inspect} \n\n")

		# first, make sure this email is not already registered
		if User.find_by(email: email)
			# this email is already registered
			return false
		else
			# move on with creating the user
			u = User.create(name: name, email: email)

			# now we need to save the password in an encrypted form,
			# so that looking at the database we won't be able to see
			# the users' passwords
			u.set_password(password)

			return true
		end
	end

	def set_password(pass)
		logger.info("\n\n ^^^^ Setting the password to: #{pass.inspect} \n\n")
		self.hashed_password = self.encrypt_password(pass)
		# don't forget to save the encrypted password
		self.save
	end

	def encrypt_password(pass)
		# we're using the SHA1 to get a digital signature from the user's password 
		# and store this into the database
		Digest::SHA1.hexdigest(pass)
	end

end
