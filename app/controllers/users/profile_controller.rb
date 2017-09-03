class Users::ProfileController < Users::BaseController
  def update
    if current_user.update(profile_params)
      redirect_to users_profile_path
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(:email, :password, :password_confirmation,
      profile_attributes: [:id, :first_name, :last_name])
  end
end
