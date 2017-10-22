class Api::V1::User::BaseController < Api::V1::BaseController
  before_action :authenticate_request!
end
