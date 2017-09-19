class ForumCategoriesController < ApplicationController
  
  before_action :find_category, only: [:destroy, :update, :show, :edit]

  def new
    @forum_category = ForumCategory.new
  end

  def create
    @forum_category = ForumCategory.new(forum_category_params)
    
    if @forum_category.save
      redirect_to forum_category_path(@forum_category), notice: 'Category created'
    else
      flash[:notice] = 'Invalid details'
      render :new
    end
  end

  def index
    @forum_categories = ForumCategory.all
  end

  def show
    if @forum_category
      @forum_category
    else
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
      redirect_to forum_category_path(@forum_category), notice: 'Category updated'
    else
      flash[:notice] = 'Invalid details'
      render :edit
    end
  end

  def destroy
    if @forum_category
      ForumCategory.destroy(params[:id])
      redirect_to forum_categories_path, notice: 'Category deleted'
    else
      render json: 'Category does not exist', status: 404
    end
  end

  private
  def find_category
    @forum_category = ForumCategory.find_by(id: params[:id])
  end

  def forum_category_params
    params.require(:forum_category).permit(:title)
  end
end
