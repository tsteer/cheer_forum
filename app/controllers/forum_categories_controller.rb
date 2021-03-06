class ForumCategoriesController < ApplicationController
  before_action :find_category, only: [:destroy, :update, :show, :edit]
  before_action :not_current_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :admins_only, only: [:new]

  def new
    @forum_category = ForumCategory.new
  end

  def create
    @forum_category = ForumCategory.new(forum_category_params)
    
    if @forum_category.save
      redirect_to forum_category_path(@forum_category), flash: { success: 'Category created' }
    else
      flash[:danger] = 'Invalid details'
      render :new
    end
  end

  def index
    @forum_categories = ForumCategory.all
  end

  def show
    unless @forum_category
      render json: 'Category does not exist', status: 404
    end
  end

  def edit
    unless @forum_category
      render plain: '404 not found', status: 404
    end
  end

  def update
    if @forum_category.update(forum_category_params)
      redirect_to forum_category_path(@forum_category), flash: { success: 'Category updated' }
    else
      flash[:danger] = 'Invalid details'
      render :edit
    end
  end

  def destroy
    if @forum_category
      ForumCategory.destroy(params[:id])
      redirect_to forum_categories_path, flash: { success: 'Category deleted' }
    else
      render json: 'Category does not exist', status: 404
    end
  end

  protected

  def after_redirect_path
    forum_categories_path
  end

  private
  
  def find_category
    @forum_category = ForumCategory.find_by(id: params[:id])
  end

  def forum_category_params
    params.require(:forum_category).permit(:title)
  end
end
