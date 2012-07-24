class VotesController < ApplicationController

  def create
    @vote = Vote.new(value: params[:value])
    @vote.voteable = Article.find_by_id(params[:article])
    @vote.user = current_user
    if @vote.save
      flash[:success] = 'Vote registered'
    else
      flash[:error] = "You can't vote twice"
    end
    redirect_to root_path
  end

end
