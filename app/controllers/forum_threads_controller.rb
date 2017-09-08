class ForumThreadsController < ApplicationController

  before_action :find_thread, only: [:show, :update, :destroy]

  def create
    forum_thread = ForumThread.create(forum_thread_params)
    if forum_thread.valid?
      render json: forum_thread
    else
      render json: 'Please complete all required fields', status: 422
    end
  end

  def index
    render json: ForumThread.all
  end

  def show
    if @forum_thread
      render json: @forum_thread, include: :forum_posts
    else
      render thread_does_not_exist
    end
  end

  def update
    render json: 'No forum thread details provided', status: 422 and return unless params[:forum_thread]
    
    if @forum_thread.update(forum_thread_params)
      render json: @forum_thread
    else
      render json: 'Did not submit the required fields', status: 422
    end
  end

  def destroy
    if @forum_thread
      ForumThread.destroy(params[:id])
    else
      render thread_does_not_exist
    end
  end

  private

  def find_thread
    @forum_thread = ForumThread.find_by(id: params[:id])
  end

  def forum_thread_params
    params.require(:forum_thread).permit(:title, :forum_category_id, :user_id)
  end 

  def thread_does_not_exist
    { json: 'Thread does not exist', status: 404 }
  end
end
