class ForumPostsController < ApplicationController

  before_action :find_post, only: [:show, :update, :destroy]

  def create
    forum_post = ForumPost.create(forum_post_params)
    
    if forum_post.valid?
      render json: forum_post
    else
      render json: 'Please complete all required fields', status: 422
    end
  end

  def index
    render json: ForumPost.all
  end

  def show
    if @forum_post
      render json: @forum_post
    else
      render json: 'Post does not exist', status: 404
    end
  end

  def update
    render json: 'No forum post details provided', status: 422 and return unless params[:forum_post]

    if @forum_post.update(forum_post_params)
      render json: @forum_post
    else
      render json: 'Did not submit the required fields', status: 422
    end
  end

  def destroy
    if @forum_post
      ForumPost.destroy(params[:id])
    else
      render json: 'Post does not exist'
    end
  end

  private

  def find_post
    @forum_post = ForumPost.find_by(id: params[:id])
  end

  def forum_post_params
    params.require(:forum_post).permit(:message, :forum_thread_id, :user_id)
  end
end
