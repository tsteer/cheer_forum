class ForumCategoriesController < ApplicationController
  before_action :find_category, only: [:destroy, :update, :show]
  def create
    forum_category = ForumCategory.create(forum_category_params)
    
    if forum_category.valid?
      render json: forum_category
    else
      render json: 'Please give the category a name', status: 422
    end
  end

  def index
    render json: ForumCategory.all.to_json
  end

  def show
    if @forum_category
      render json: @forum_category
    else
      render json: 'Category does not exist', status: 404
    end
  end

  def update
    render json: 'No forum category details provided', status: 422 and return unless params[:forum_category]

    if @forum_category.update(forum_category_params)
      render json: @forum_category
    else
      render json: 'Please fill in a category title', status: 422
    end
  end

  def destroy
    if @forum_category
      ForumCategory.destroy(params[:id])
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
