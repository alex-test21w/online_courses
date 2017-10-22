class AuthUser
  include AuthHelper

  def self.call(params)
    interactor = new(params)
    interactor.run
    interactor
  end

  attr_reader :error, :params, :token

  def initialize(params)
    @params = params
  end

  def success?
    @error.nil?
  end

  def run
    if are_params_valid?
      @token = authenticate_by_email
    else
      fail!('Invalid email or password')
    end
  end

  private

  def fail!(error)
    @error = error
  end

  def are_params_valid?
    params[:password].present? && params[:email].present?
  end

  def authenticate_by_email
    user = User.find_by_email(params[:email])
    auth_token(user.id) if user.present? && user.valid_password?(params[:password])
  end
end
