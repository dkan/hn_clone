class CommentsController < ApplicationController
  def show
    @original_comment = Comment.find_by_id(params[:id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment[:user_id] = current_user.id
    if @comment.save
      flash[:success] = "Thanks for commenting"
      @comment.votes.create(:user_id => current_user.id, :value => 1)
      redirect_to article_path(@comment.article)
    else
      flash[:error] = "Comment can't be blank"
      redirect_to article_path(@comment.article)
    end
  end
end
