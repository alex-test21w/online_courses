module OmniauthMacros
  def mock_auth_twitter
    OmniAuth.config.mock_auth[:twitter] =
      OmniAuth::AuthHash.new(
        {
        'provider': 'twitter',
        'uid':      '123545',
        'extra': {
          'raw_info': {
            'name':  'mockuser'
          }
        },
        'credentials': {
          'token':  'mock_token',
          'secret': 'mock_secret'
        }
      })
  end

  def mock_auth_facebook
    OmniAuth.config.mock_auth[:facebook] =
      OmniAuth::AuthHash.new(
        {
          'provider': 'facebook',
          'uid':      '123545',
          'extra': {
            'raw_info': {
              'name':  'mockuser'
            }
          },
          'credentials': {
            'token':  'mock_token',
            'secret': 'mock_secret'
          }
        })
  end


end
