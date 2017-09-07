class ForumPostsController < ApplicationController

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
    forum_post = ForumPost.find_by(id: params[:id])
    if forum_post
      render json: forum_post
    else
      render json: 'Post does not exist', status: 404
    end
  end

  private

  def forum_post_params
    params.require(:forum_post).permit(:message, :forum_thread_id, :user_id)
  end
end
