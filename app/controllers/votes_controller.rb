class VotesController < ApplicationController

  def create
    @vote = Vote.new(params[:vote])
    @vote.user = current_user
    respond_to do |format|
      if @vote.save
        format.html do
          flash[:success] = 'Vote registered'
          redirect_to redirect_path
        end
        format.js
      else
        format.html do
          flash[:error] = @vote.errors.full_messages.first
          redirect_to redirect_path
        end
        format.js
      end
    end
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
