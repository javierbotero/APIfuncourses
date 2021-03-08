class CommentsController < ApplicationController
  before_action :authenticate
  include Helpers

  def create
    @user = User.find(params[:current_user_id])
    @comment = @user.comments.build(comment_params)

    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.full_messages, status: 404
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if match_user_ids(@comment.user.id) && @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors.full_messages, status: 404
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if match_user_ids(@comment.user.id)
      @comment.destroy

      render json: 'Comment deleted'
    else
      render json: 'You are not allowed to delete the comment', status: 404
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:course_id, :body)
  end
end