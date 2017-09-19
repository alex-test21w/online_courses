class SocialServices::Twitter < SocialServices::Base
  def initialize(access_token, secret_key)
    @access_token, @secret_key = access_token, secret_key
  end

  def authenticate
    social_profile = SocialProfile.where(service_name: 'twitter', uid: twitter_client.id).first_or_create

    if social_profile.user.present?
      auth_token(social_profile.user.id)
    else
      create_social_profile(social_profile)
    end
  end

  def create_social_profile(social_profile)
    social_profile.user = create_user
    social_profile.save!

    auth_token(social_profile.user.id)
  end

  def create_user
    first_name, last_name = twitter_client.name.split(' ')

    user = User.new(profile_attributes: { first_name: first_name, last_name: last_name })
    user.social_login = true

    user
  end

  def twitter_client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = OmniauthConfig['twitter']['token']
      config.consumer_secret     = OmniauthConfig['twitter']['key']
      config.access_token        = @access_token
      config.access_token_secret = @secret_key
    end

    client.user
  end
end
