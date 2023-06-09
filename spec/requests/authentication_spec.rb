# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
  describe 'POST /authenticate' do
    let(:user) { FactoryBot.create(:user, username: 'user1', password: 'foobar') }

    it 'should authenticate the user' do
      token = AuthenticationTokenService.encode(user.id)
      post '/api/v1/authenticate',
           params: {
             username: user.username,
             password: 'foobar'
           }
      expect(response).to have_http_status(:created)
      expect(response_body).to include({ 'token' => token })
    end

    it 'should return error message when username is missing' do
      post api_v1_authenticate_path, params: { password: 'foobar' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq(
        { 'error' => 'param is missing or the value is empty: username' }
      )
    end

    it 'should return error message when password is missing' do
      post api_v1_authenticate_path, params: { username: 'user1' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq(
        { 'error' => 'param is missing or the value is empty: password' }
      )
    end

    it 'should return when password is incorrect' do
      post api_v1_authenticate_path, params: { username: user.username, password: 'wrong' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
