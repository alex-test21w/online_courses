class CreateAuthToken
  def self.call(params)
    interactor = new(params)
    interactor.run
    interactor
  end

  attr_reader :error, :params, :auth_token

  def initialize(params)
    @params = params
  end

  def success?
    @error.nil?
  end

  def run
    if are_params_valid?
      @auth_token = authenticate_through_social_networks
    else
      fail!('Please check the accuracy of the input parameters')
    end
  end

  private

  def fail!(error)
    @error = error
  end

  def are_params_valid?
    params[:service_name].present? && params[:access_token].present? && params[:secret_key].present?
  end

  def authenticate_through_social_networks
    api_client = SocialServices::Base.service_for(params[:service_name]).new(params[:access_token], params[:secret_key])
    api_client.authenticate
  end
end
