class ForumThreadsController < ApplicationController
  before_action :find_thread, only: [:show, :update, :destroy, :edit]
  before_action :not_current_user, only: [:new, :create, :edit, :update, :destroy]

  def new
    @forum_thread = ForumThread.new
  end

  def create
    @forum_thread = ForumThread.new(forum_thread_params)
    
    if @forum_thread.save
      redirect_to forum_thread_path(@forum_thread), flash: { success: 'Thread created' }
    else
      flash[:danger] = 'Invalid details'
      render :new
    end
  end

  def index
    @forum_thread = ForumThread.all
  end

  def show
    if @forum_thread
      @forum_posts = @forum_thread.forum_posts
      @forum_post = @forum_thread.forum_posts.new
    else
      render thread_does_not_exist
    end
  end

  def edit
    unless @forum_thread
      render plain: '404 not found', status: 404
    end
  end

  def update
    if @forum_thread.update(forum_thread_params)
      redirect_to forum_thread_path(@forum_thread), flash: { success: 'Thread updated' }
    else
      flash[:danger] = 'Invalid details'
      render :edit
    end
  end

  def destroy
    if @forum_thread
      ForumThread.destroy(params[:id])
      redirect_to forum_categories_path, flash: { success: 'Thread deleted' }
    else
      render thread_does_not_exist
    end
  end

  private

  def find_thread
    @forum_thread = ForumThread.find_by(id: params[:id])
  end

  def forum_thread_params
    params.require(:forum_thread).permit(:title, :forum_category_id, :user_id, :message)
  end 

  def thread_does_not_exist
    { json: 'Thread does not exist', status: 404 }
  end
end
