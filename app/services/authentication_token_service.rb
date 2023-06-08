# frozen_string_literal: true

class AuthenticationTokenService
  HMAC_SECRET = 'my$ecretK3y'
  ALGORITHM_TYPE = 'HS256'

  def self.call(payload)
    payload = { user_id: payload }
    JWT.encode(payload,
               HMAC_SECRET,
               ALGORITHM_TYPE)
  end
end
