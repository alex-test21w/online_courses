class RegistrationsController < Devise::RegistrationsController
  def new
    build_resource({})
    resource.profile = Profile.new
    respond_with resource
  end

  private

  def sign_up_params
    allow = [:email, :password, :password_confirmation, [profile_attributes: [:first_name, :last_name]]]
    params.require(resource_name).permit(allow)
  end
end
