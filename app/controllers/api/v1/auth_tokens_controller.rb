class Api::V1::AuthTokensController < Api::V1::BaseController
  skip_before_action :authenticate_request!

  rescue_from Twitter::Error, RuntimeError do |e|
    render_error(e.message, 406)
  end

  rescue_from Twitter::Error::Unauthorized, with: :user_not_authenticated

  def create
    if params[:service_name].present? && params[:access_token].present? && params[:secret_key].present?
      auth_token = authenticate_through_social_networks

      if auth_token.present?
        respond_with_success({ auth_token: auth_token }, 201)
      else
        raise Exceptions::NotAuthenticatedError
      end
    else
      render_error 'Invalid params', 406
    end
  end

  private

  def authenticate_through_social_networks
    api_client = SocialServices::Base.service_for(params[:service_name]).new(params[:access_token], params[:secret_key])
    api_client.authenticate
  end
end
