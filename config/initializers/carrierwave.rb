CarrierWave.configure do |config|
  config.storage    = :file
  config.root       = Rails.root.join('public')
  config.asset_host = ActionController::Base.asset_host
end
