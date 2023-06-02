require 'rails_helper'

RSpec.describe "Authors", type: :request do
  describe "POST /authors" do
    it "returns http created" do
      post "/api/v1/authors", params: {author: {first_name: "JK", last_name: "Rowling", age: 55} }
      expect(response).to have_http_status(:created)
    end
  end

end
