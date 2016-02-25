class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_action :check_if_admin

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.'}
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def delete
  end

  def update
     respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was succesfully destroyed'}
    end
  end

  def remove_admin
    logger.info("\n\n ^^^^ Remove admin rights for user id: #{params[:id]} \n\n")
    # load the user
    user = User.find(params[:id])

    if user
      user.remove_admin
    end

    redirect_to action: 'index'
  end

  def make_admin
    logger.info("\n\n ^^^^ Give admin rights for user id: #{params[:id]} \n\n")
    # load the user
    user = User.find(params[:id])

    if user
      user.make_admin
    end

    redirect_to action: 'index'
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :hashed_password)
    end

    def check_if_admin
      if logged_in_user and logged_in_user.website_admin?
        # this guy is a webiste admin, give him access
      else
        redirect_to books_path
      end
    end

end
