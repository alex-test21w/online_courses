class Api::V1::AuthUsersController < Api::V1::BaseController
  skip_before_action :authenticate_request!

  def create
    if params[:email].present? && params[:password].present?
      auth_token = authenticate_by_email

      if auth_token.present?
        respond_with_success({ auth_token: auth_token }, 201)
      else
        raise Exceptions::NotAuthenticatedError
      end
    else
      render_error 'Invalid email or password', 406
    end
  end

  private

  def authenticate_by_email
    user = User.find_by_email(params[:email])
    auth_token(user.id) if user.present? && user.valid_password?(params[:password])
  end
end
