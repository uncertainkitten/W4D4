class SessionsController < ApplicationController
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
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])

    if @user
      login!(@user)
      redirect_to user_url
    else
      flash[:errors] = ["Email or password invalid"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
