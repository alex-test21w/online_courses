class Api::V1::BaseController < ActionController::Base
  include AuthHelper

  respond_to :json

  attr_reader :current_user

  before_action :authenticate_request!

  rescue_from Exception, with: :respond_with_internal_error
  rescue_from Exceptions::NotAuthenticatedError, with: :user_not_authenticated
  rescue_from JWT::ExpiredSignature, with: :authentication_timeout
  rescue_from CanCan::AccessDenied, Exceptions::NotAuthorizedError, with: :user_not_authorized

  rescue_from ActiveRecord::RecordNotFound,
              ActionController::RoutingError,
              ActiveRecord::RecordInvalid,
              with: :respond_with_not_found

  protected

  def authenticate_request!
    raise Exceptions::NotAuthenticatedError unless user_id_included_in_auth_token?

    @current_user = User.find(decoded_auth_token[:user_id])
  rescue JWT::ExpiredSignature
    raise Exceptions::AuthenticationTimeoutError
  rescue JWT::VerificationError, JWT::DecodeError
    raise Exceptions::NotAuthenticatedError
  end

  private

  def user_id_included_in_auth_token?
    http_auth_token && decoded_auth_token && decoded_auth_token[:user_id]
  end

  def decoded_auth_token
    @decoded_auth_token ||= AuthToken.decode(http_auth_token)
  end

  def http_auth_token
    @http_auth_token ||= if request.headers['X-Auth-Token'].present?
                           request.headers['X-Auth-Token'].split(' ').last
                         end
  end

  def respond_with_success(data, status=200)
    render json: data, status: status
  end

  def render_success(data, status_code=200)
    render json: { data: data },
           status: status_code
  end

  def respond_with_error(object, status=422)
    render json: { success: false, errors: object.errors, errors_messages: object.errors.full_messages }, status: status
  end

  def render_error(text, status_code=422)
    render json: { error: { message: text } },
           status: status_code
  end

  def respond_with_not_found
    render json: { success: false, message: 'Cant found record' }, status: 404
  end

  def respond_with_internal_error(exception)
    response = { success: false, message: 'Internal error' }
    response[:debug] = exception.message unless Rails.env.production?

    render json: response, status: 500
  end

  def authentication_timeout
    render_error 'Authentication Timeout', 419
  end

  def user_not_authorized
    render_error 'Not Authorized', 401
  end

  def user_not_authenticated
    render_error 'Not Authenticated', 401
  end
end
