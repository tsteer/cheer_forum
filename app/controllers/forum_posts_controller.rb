class ForumPostsController < ApplicationController

  before_action :find_post, only: [:show, :update, :destroy, :edit]

  def create
    forum_post = ForumPost.new(forum_post_params)
    forum_post.user = User.create(username: 'Testusername', email: 'test@test.com', date_of_birth: '1990-08-01')

    if forum_post.valid?
      redirect_to forum_thread_path(forum_post.forum_thread), flash: { success: 'Message posted' }
    else
      redirect_to forum_thread_path(forum_post.forum_thread), flash: { danger: 'Invalid details' }
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

  def edit
    unless @forum_post
      render plain: '404 not found', status: 404 and return
    end
    @forum_thread = @forum_post.forum_thread
  end

  def update
      @forum_thread = @forum_post.forum_thread

    if @forum_post.update(forum_post_params)
      redirect_to forum_thread_path(@forum_thread), flash: { success: 'Post updated' }
    else
      flash[:danger] = 'Invalid details'
      render :edit
    end
  end

  def destroy
    forum_thread = @forum_post.forum_thread

    if @forum_post
      ForumPost.destroy(params[:id])
      redirect_to forum_thread_path(forum_thread), flash: { success: 'Post deleted' }
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
