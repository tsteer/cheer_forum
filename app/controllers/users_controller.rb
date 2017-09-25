class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      log_in(@user)
      redirect_to user_path(@user), notice: 'User created'
    else
      flash[:notice] = 'Invalid details'
      render :new
    end
  end

  def show
    if @user
      @user
    else
      render plain: '404 not found', status: 404
    end
  end

  def index
    redirect_to forum_categories_path, notice: 'Permission denied' unless current_user.admin?
    @users = User.all
  end

  def edit
    unless @user
      render plain: '404 not found', status: 404
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'User updated'
    else
      flash[:notice] = 'Invalid details'
      render :edit
    end
  end

  def destroy
    if @user
      User.destroy(params[:id])
      redirect_to new_user_path, notice: 'Account deleted'
    else
      render plain: '404 not found', status: 404
    end
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :date_of_birth, :password, :password_confirmation)
  end
end
