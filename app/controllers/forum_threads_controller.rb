class ForumThreadsController < ApplicationController

  before_action :find_thread, only: [:show, :update, :destroy]

  def new
    @forum_thread = ForumThread.new
  end

  def create
    @forum_thread = ForumThread.new(forum_thread_params)
    @forum_thread.user = User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01')
    if @forum_thread.save
      redirect_to forum_thread_path(@forum_thread), notice: 'Thread created'
    else
      flash[:notice] = 'Invalid details'
      render :new
    end
  end

  def index
    render json: ForumThread.all
  end

  def show
    if @forum_thread
      @forum_post = @forum_thread.forum_posts.new
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
