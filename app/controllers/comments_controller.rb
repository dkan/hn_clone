class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment])
    @comment[:user_id] = current_user.id
    if @comment.save
      flash[:success] = "Thanks for commenting"
      @comment.votes.create(:user_id => current_user.id, :value => 1)
      redirect_to article_path(@comment.article)
    else
      flash[:error] = "Invalid Submission"
      redirect_to article_path(@comment.article)
    end
  end
end
