class SessionsController < ApplicationController

  def new
  end

  # NoMethodError: undefined method `remember_token' for nil:NilClass
  # test/integration/users_login_test.rb:32:in `block in <class:UsersLoginTest>'　SessionController#createで@userへの代入を行っていなかった
  
  # def create
  #   user = User.find_by(email: params[:session][:email].downcase)
  #   if user && user.authenticate(params[:session][:password])
  #     log_in user
  #     params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  #     redirect_back_or user
  #   else
  #     flash.now[:danger] = 'Invalid email/password combination'
  #     render 'new'
  #   end
  # end


  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or @user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end