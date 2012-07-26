class CommentsController < ApplicationController
  def show
    @original_comment = Comment.find_by_id(params[:id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment[:user_id] = current_user.id
    respond_to do |format|
      if @comment.save
        @comment.votes.create(:user_id => current_user.id, :value => 1)
        format.html do
          flash[:success] = "Thanks for commenting"
          redirect_to article_path(@comment.article)
        end
        format.js
      else
        format.html do
          flash[:error] = "Comment can't be blank"
          redirect_to article_path(@comment.article)
        end
        format.js
      end

    end
  end
end

