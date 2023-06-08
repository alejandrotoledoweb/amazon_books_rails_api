class AuthenticationTokenService
  def self.call
    hmac_secret = "my$ecretK3y"
    payload = { user_id: "User1" }
    token = JWT.encode payload, hmac_secret, "HS256"
  end
end
