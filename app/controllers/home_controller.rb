class HomeController < ApplicationController
  def index
    @articles = Article.all
    @forum_threads = ForumThread.all
  end
end
