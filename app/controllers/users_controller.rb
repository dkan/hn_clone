class UsersController < ApplicationController

  def show
    @user = User.find_by_id(params[:id])
    @articles = Article.where(user_id: @user.id).page(params[:page]).per(5)
  end

end
