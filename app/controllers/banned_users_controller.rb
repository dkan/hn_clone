class BannedUsersController < ApplicationController
  def create
    if current_user.admin?
      @banned_user = BannedUser.new(params[:banned_user])
      if @banned_user.save
        flash[:success] = 'User has been banned!'
      else
        flash[:error] = 'Error: User has not been banned'
      end
      redirect_to :back
    end
  end
end
