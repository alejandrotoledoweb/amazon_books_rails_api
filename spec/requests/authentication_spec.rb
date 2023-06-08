require "rails_helper"

RSpec.describe "Authentications", type: :request do
  describe "POST /index" do
    it "should authenticate the user" do
      post "/api/v1/authenticate",
           params: {
             username: "user1",
             password: "foobar"
           }
      expect(response).to have_http_status(:created)
      expect(response_body).to include({ "token" => "123" })
    end

    it "should return error message when username is missing" do
      post api_v1_authenticate_path, params: { password: "foobar" }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq(
        { "error" => "param is missing or the value is empty: username" }
      )
    end

    it "should return error message when password is missing" do
      post api_v1_authenticate_path, params: { username: "user1" }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq(
        { "error" => "param is missing or the value is empty: password" }
      )
    end
  end
end
