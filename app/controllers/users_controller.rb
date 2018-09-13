class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to session_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private
  def user_params
    user_params.require(:user).permit(:email, :password)
  end
end
