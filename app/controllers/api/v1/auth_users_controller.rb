class Api::V1::AuthUsersController < Api::V1::BaseController
  def create
    interactor = AuthUser.call(auth_params)

    if interactor.success?
      raise Exceptions::NotAuthenticatedError unless interactor.token.present?

      respond_with_success({ auth_token: interactor.token }, 201)
    else
      render_error interactor.error, 406
    end
  end

  private

  def auth_params
    params.permit(:password, :email)
  end
end
