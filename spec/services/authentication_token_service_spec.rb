# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticationTokenService do
  let(:user) { FactoryBot.create(:user, username: 'BookSeller99') }
  describe '.call' do
    let(:token) { described_class.call(1) }
    it 'should return an authentication token' do
      decoded_token = JWT.decode(token,
                                 described_class::HMAC_SECRET,
                                 true,
                                 { algorithm: described_class::ALGORITHM_TYPE })
      expect(decoded_token).to eq([
                                    { 'user_id' => 1 },
                                    { 'alg' => 'HS256' }
                                  ])
    end
  end
end
