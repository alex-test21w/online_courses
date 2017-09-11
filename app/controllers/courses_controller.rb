class CoursesController < ApplicationController
  PER_PAGE = 5

  def index
    @courses = Course.visible.recent.page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def show
    @course = Course.find(params[:id])
  end
end
