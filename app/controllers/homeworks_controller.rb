class HomeworksController < ApplicationController
  before_action :load_homework, only: :show
  authorize_resource only: :show

  PER_PAGE = 10

  def index
    @homework = current_user.homeworks.includes(:lesson).recent.page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def show
    @comments = @homework.comments.includes(user: :profile)
  end

  private

  def load_homework
    @homework = Homework.find(params[:id])
  end
end
