class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_to root_path, flash: { success: 'Logged in' }
    else
      flash[:danger] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_path, flash: { success: 'Logged out' }
  end
end
