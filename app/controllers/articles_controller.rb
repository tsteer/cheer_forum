class ArticlesController < ApplicationController 
  before_action :find_article, only: [:update, :edit, :show, :destroy]
  before_action :admins_only, only: [:new]

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to articles_path, notice: 'Article posted'
    else
      flash[:notice] = 'Invalid details'
      render :new
    end
  end

  def index
    @articles = Article.all
  end

  def show
  end

  def edit
    unless @article
      render plain: '404 not found', status: 404
    end
  end

  def update
    if @article.update(article_params)
      redirect_to articles_path, notice: 'Article updated'
    else
      flash[:notice] = 'Invalid details'
      render :edit
    end
  end

  def destroy
    if @article
      Article.destroy(params[:id])
      redirect_to articles_path, notice: 'Article deleted'
    end
  end

  protected

  def after_redirect_path
    articles_path
  end

  private

  def find_article
    @article = Article.find_by(id: params[:id])
  end

  def article_params
    params.require(:article).permit(:author, :title, :subheading, :article_text)
  end
end
