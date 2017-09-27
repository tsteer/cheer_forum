class UsersController < ApplicationController
  before_action :not_current_user, only: [:edit, :update, :destroy, :index]
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :admins_only, only: [:index]

  def new
    redirect_to root_path, flash: { danger: 'You are already signed up!' } and return if current_user
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      log_in(@user)
      redirect_to user_path(@user), flash: { success: 'User created' }
    else
      flash[:danger] = 'Invalid details'
      render :new
    end
  end

  def show
    unless @user
      render plain: '404 not found', status: 404
    end
  end

  def index
    @users = User.all
  end

  def edit
    unless @user
      render plain: '404 not found', status: 404
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), flash: { success: 'User updated' }
    else
      flash[:danger] = 'Invalid details'
      render :edit
    end
  end

  def destroy
    if @user
      User.destroy(params[:id])
      redirect_to new_user_path, flash: { success: 'Account deleted' }
    else
      render plain: '404 not found', status: 404
    end
  end

  protected

  def after_redirect_path
    forum_categories_path
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :date_of_birth, :password, :password_confirmation)
  end
end
