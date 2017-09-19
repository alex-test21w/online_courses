module Exceptions
  class NotAuthorizedError         < StandardError; end
  class NotAuthenticatedError      < StandardError; end
  class AuthenticationTimeoutError < StandardError; end
end
