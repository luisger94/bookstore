class AuthenticationController < ApplicationController
  def signup
    if request.post? 
      if User.register_user(params[:name], params[:email], params[:password])
        flash.now[:notice] = "User registered successfully"
        # after the user has logged in, take them to the books index
        redirect_to books_path
      else
        # this email is already registered
        flash.now[:notice] = "This email is already registered. Try logging in instead!"
      end
    end
  end

  def login
    if request.post?
      if User.authenticate(params[:email], params[:password])
        flash.now[:notice] = "User logged in successfully"
        # after the user has logged in, take them to the books index
        redirect_to books_path
      else
        # this email is already registered
        flash.now[:notice] = "Wrong email or password"
      end
    end
  end
   


  def logout
  end
end
