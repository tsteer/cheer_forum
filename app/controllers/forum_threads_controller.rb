  class ForumThreadsController < ApplicationController

    def create
      forum_thread = ForumThread.create(forum_thread_params)
      if forum_thread.valid?
        render json: forum_thread
      else
        render json: 'Please complete all required fields', status: 422
      end
    end

    private

    def forum_thread_params
      params.require(:forum_thread).permit(:title, :forum_category_id, :user_id)
    end 
  end
