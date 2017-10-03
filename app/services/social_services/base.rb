class SocialServices::Base
  include AuthHelper

  PROVIDERS = %[Facebook Twitter]

  def self.service_for(service_name)
    service = service_name.capitalize

    if PROVIDERS.include?(service)
      "SocialServices::#{service}".classify.constantize
    else
      raise Exceptions::ServiceNotFoundError
    end
  end
end
