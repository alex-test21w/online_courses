class HomeworksController < ApplicationController
  def show
    @homework = current_user.homeworks.find(params[:id])
  end
end
