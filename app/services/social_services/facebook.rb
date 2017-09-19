class SocialServices::Facebook < SocialServices::Base

  def initialize(access_token, secret_key)
    @access_token, @secret_key = access_token, secret_key
  end

  def authenticate; end
end
