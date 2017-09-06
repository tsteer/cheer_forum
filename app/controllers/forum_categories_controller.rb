class ForumCategoriesController < ApplicationController
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
    forum_category = ForumCategory.find_by(id: params[:id])
    
    if forum_category.nil?
      render json: 'Category does not exist', status: 404
    else
      render json: forum_category
    end
  end

  private

  def forum_category_params
    params.require(:forum_category).permit(:title)
  end
end
