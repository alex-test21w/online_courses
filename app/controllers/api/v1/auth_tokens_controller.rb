class Api::V1::AuthTokensController < Api::V1::BaseController
  skip_before_action :authenticate_request!

  rescue_from Twitter::Error, Exception do |e|
    render_error(e.message, 406)
  end

  rescue_from Twitter::Error::Unauthorized, Exceptions::NotAuthorizedError, with: :user_not_authorized

  def create
    if params[:service_name].present? && params[:access_token].present? && params[:secret_key].present?
      auth_token = authenticate_through_social_networks

      if auth_token.present?
        respond_with_success({ auth_token: auth_token }, 201)
      else
        raise Exceptions::NotAuthorizedError
      end
    else
      render_error 'Please check the accuracy of the input parameters', 406
    end
  end

  private

  def authenticate_through_social_networks
    api_client = SocialServices::Base.service_for(params[:service_name]).new(params[:access_token], params[:secret_key])
    api_client.authenticate if api_client.present?
  end
end
