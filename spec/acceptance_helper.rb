require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.filter = :v1
  config.curl_host = 'http://localhost:3000'
  config.curl_headers_to_filter = %w(Host Cookie Content-Type)
  config.request_headers_to_include = %w(Accept X-Auth-Token)
  config.request_headers_to_include = %w(Accept X-Temporary-Token)
  config.response_headers_to_include = %w(Content-Type Cache-Control)

  config.define_group :v1 do |group|
    group.docs_dir = Rails.root.join('doc', 'api', 'v1')
    group.format = :json
    group.filter = :v1
  end
end
