class ForumThreadsController < ApplicationController

  def create
    forum_thread = ForumThread.create(forum_thread_params)
    if forum_thread.valid?
      render json: forum_thread
    else
      render json: 'Please complete all required fields', status: 422
    end
  end

  def index
    render json: ForumThread.all.to_json
  end

  def show
    forum_thread = ForumThread.find_by(id: params[:id])
    
    if forum_thread
      render json: forum_thread
    else
      render json: 'Thread does not exist', status: 404
    end
  end

  def update
    render json: 'No forum thread details provided', status: 422 and return unless params[:forum_thread]
    
    forum_thread = ForumThread.find_by(id: params[:id])
    
    if forum_thread.update(forum_thread_params)
      render json: forum_thread
    else
      render json: 'Did not submit the required fields'
    end
  end

  private

  def forum_thread_params
    params.require(:forum_thread).permit(:title, :forum_category_id, :user_id)
  end 
end
