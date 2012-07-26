class VotesController < ApplicationController

  def create
    @vote = Vote.new(params[:vote])
    @vote.user = current_user
    if @vote.save
      flash[:success] = 'Vote registered'
    else
      flash[:error] = @vote.errors.full_messages.first
    end
    redirect_to redirect_path
  end

  private

  def redirect_path
    case @vote.voteable_type
    when 'Article'
      root_path
    when 'Comment'
      article_path(@vote.voteable.article)
    end
  end
end
