require 'sidekiq'
require 'sidekiq-status'

Sidekiq.configure_server do |config|
  config.redis = { namespace: "online_courses_#{Rails.env}" }

  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes # default
  end
end

Sidekiq.configure_client do |config|
  config.redis = { namespace: "online_courses_#{Rails.env}" }

  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
end

# Cron init schedule
schedule_file = 'config/schedule.yml'

if File.exists?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end
