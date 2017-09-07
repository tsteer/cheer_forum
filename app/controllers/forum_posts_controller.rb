class ForumPostsController < ApplicationController

  def create
    forum_post = ForumPost.create(forum_post_params)
    if forum_post.valid?
      render json: forum_post
    else
      render json: 'Please complete all required fields', status: 422
    end
  end

  private

  def forum_post_params
    params.require(:forum_post).permit(:message, :forum_thread_id, :user_id)
  end
end
