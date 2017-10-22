class Api::V1::AuthTokensController < Api::V1::BaseController
  def create
    interactor = CreateAuthToken.call(auth_params)

    if interactor.success?
      raise Exceptions::NotAuthorizedError unless interactor.auth_token.present?

      respond_with_success({ auth_token: interactor.auth_token }, 201)
    else
      render_error interactor.error, 406
    end
  end

  private

  def auth_params
    params.permit(:service_name, :access_token, :secret_key)
  end
end
