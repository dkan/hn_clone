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

end
