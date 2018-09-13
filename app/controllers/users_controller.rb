class UsersController < ApplicationController
  before_action :login_redirect, only: [:new, :create]

  def login_redirect
    if logged_in?
      redirect_to user_url(@user)
    end
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by(session_token: session[:session_token])
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
