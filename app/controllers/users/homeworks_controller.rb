class Users::HomeworksController < Users::BaseController
  before_action :load_homework, only: [:show, :update]

  PER_PAGE = 10

  STATES = %w[approved rejected].freeze

  def index
    @homeworks = lesson.homeworks.includes(user: :profile).recent.page(params[:page]).per(params[:per_page] || PER_PAGE)
  end

  def update
    if STATES.include?(params[:state])
      @homework.update!(state: params[:state])

      send_homework_to_activities
    else
      flash[:error] = "You can't set #{params[:state]} state"
    end
  end

  private

  def course
    @course ||= current_user.authored_courses.find_by(id: params[:course_id])
  end
  helper_method :course

  def lesson
    @lesson ||= course.lessons.find_by(id: params[:lesson_id])
  end
  helper_method :lesson

  def load_homework
    @homework ||= lesson.homeworks.find(params[:id])
  end

  def send_homework_to_activities
    state =
      if params[:state] == 'approved'
        Activity::KIND_HOMEWORK_APPROVED
      else
        Activity::KIND_HOMEWORK_REJECTED
      end

    Activity.create!(
      recipient_id: @homework.user_id,
      owner_id: current_user.id,
      trackable: @homework,
      kind: state,
      message: "Homework has been #{state}"
    )
  end
end
