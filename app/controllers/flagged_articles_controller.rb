class FlaggedArticlesController < ApplicationController
  def create
    if current_user.admin?
      @flagged_article = FlaggedArticle.new(params[:flagged_article])
      if @flagged_article.save
        flash[:success] = 'Article has been flagged!'
      else
        flash[:error] = 'Error: article has not been flagged'
      end
      redirect_to :back
    end
  end
end
