class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]
  before_action :correct_user, only: [:show]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Sign up successful! Welcome to Contacts App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Confirms that user is logged in
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please login first."
        redirect_to login_url
      end
    end

    # Confirms that the user is correct
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
