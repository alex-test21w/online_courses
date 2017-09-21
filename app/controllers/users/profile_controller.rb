class Users::ProfileController < Users::BaseController
  def show
    @courses = current_user.course_users.includes(:course).only_subscriptions.recent
    @activities = current_user.activities_for_me.includes(:trackable, owner: :profile).recent.decorate
  end

  def update
    if current_user.update(profile_params)
      redirect_to users_profile_path
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(
      :email, :picture, :password, :password_confirmation,
      profile_attributes: %i[id first_name last_name]
    )
  end
end
