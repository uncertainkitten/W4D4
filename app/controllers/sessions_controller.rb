class SessionsController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(email: params[:user][:email], password: params[:user][:password])

    if @user
      session[:session_token] = @user.session_token
      redirect_to users_url
    else
      flash[:errors] = ["Email or password invalid"]
      render :new
    end
  end
end
