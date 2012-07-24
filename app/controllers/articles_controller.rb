class ArticlesController < ApplicationController

  def index
    @articles = Article.page(params[:page]).per(5)
  end

  def new
    @article = Article.new
    unless signed_in?
      flash[:error] = 'You must be logged in to submit an article'
      redirect_to signin_path
    end
  end

  def create
    @article = Article.new(params[:article])
    @article[:user_id] = current_user.id
    if @article.save
      flash[:success] = "Thanks for submitting an article"
      @article.votes.create(:user_id => current_user.id)
      redirect_to root_path
    else
      flash[:error] = "Invalid Submission"
      render 'new'
    end
  end

  def edit
    @article = Article.find_by_id(params[:id])
    unless current_user == @article.user
      flash[:error] = "That article doesn't belong to you!"
      redirect_to root_path
    end
  end

  def update
    @article = Article.find_by_id(params[:id])
    if current_user == @article.user && @article.update_attributes(params[:article])
      flash[:success] = 'Article successfully updated'
      redirect_to user_path(current_user)
    else
      flash[:error] = "Invalid Edit"
      redirect_to edit_article_path(@article)
    end
  end
end
