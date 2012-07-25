class VotesController < ApplicationController

  def create
    @vote = Vote.new(params[:vote])
    @vote.user = current_user
    if @vote.save
      flash[:success] = 'Vote registered'
    else
      flash[:error] = "You can't vote twice"
    end
    redirect_to root_path
  end

end
