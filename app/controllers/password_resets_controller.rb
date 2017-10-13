class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:success] = 'Reset password email sent'
      redirect_to login_path
    else
      flash[:danger] = 'Email address not found'
      render :new
    end
  end

  def edit
    if params[:id].blank?
      flash[:danger] = 'You are not authorized to view this page'
      redirect_to root_url
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, 'Cannot be empty')
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = 'Password has been reset'
      redirect_to root_url
    else
      flash[:danger] = 'Password and confirmation must match'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless (@user)
      binding.pry
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = 'Password reset has expired'
      redirect_to new_password_reset_url
    end
  end
end