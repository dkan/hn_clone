class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Thanks for signing up"
      redirect_to root_path
    else
      flash[:error] = "Invalid Information"
      render 'new'
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    @articles = Article.where(user_id: @user.id).page(params[:page]).per(5)
    p Article.where(user_id: @user.id)
        p Article.where(user_id: @user.id).class
  end

end
