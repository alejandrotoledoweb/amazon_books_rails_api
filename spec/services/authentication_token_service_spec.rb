require 'rails_helper'

RSpec.describe AuthenticationTokenService do
  describe '.call' do
    it 'should return an authentication token' do
      hamc_secret = 'my$ecretK3y'
      token = described_class.call
      decoded_token = JWT.decode token, hamc_secret, true, { algorithm: 'HS256' }
      expect(decoded_token).to eq([
                                    { 'user_id' => 'User1' },
                                    { 'alg' => 'HS256' }
                                  ])
    end
  end
end
