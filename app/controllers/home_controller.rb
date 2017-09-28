class HomeController < ApplicationController
  def index
    @articles = Article.latest
    @forum_threads = ForumThread.latest
  end
end
