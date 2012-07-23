class ArticlesController < ApplicationController

  def index
    @articles = Article.page(params[:page]).per(5)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      flash[:success] = "Thanks for submitting an article"
      redirect_to root_path
    else
      flash[:error] = "Invalid Submission"
      render 'new'
    end
  end
end
