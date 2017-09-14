class Users::ActivitiesController < Users::BaseController
  def index
    @activities = current_user.activities_for_me.includes(:trackable).recent.decorate
  end
end
