class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = current_user.comments.build(comment_params)
    comment.commentable = parent

    if comment.save
      flash[:success] = 'Comment was succesfully created'
    else
      flash[:error] = 'Comment not created'
    end

    redirect_back fallback_location: root_path
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy

    redirect_back fallback_location: root_path
  end

  private

  def parent
    @parent ||=
      if params[:lesson_id].present?
        Lesson.find(params[:lesson_id])
      elsif params[:homework_id].present?
        Homework.find(params[:homework_id])
      end
  end

  def lesson
    @lesson ||= Lesson.find(params[:lesson_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
