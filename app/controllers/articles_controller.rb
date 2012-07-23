class ArticlesController < ApplicationController

  def index
    @articles = Article.all.reverse
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      redirect_to root_path
    else
      render 'new'
    end
  end
end
