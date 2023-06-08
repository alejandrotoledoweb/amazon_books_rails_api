require "rails_helper"

RSpec.describe Api::V1::BooksController, type: :controller do
  it "should return a subset max of 100 book the limit is greater than 100" do
    expect(Book).to receive(:limit).with(100).and_call_original

    get :index, params: { limit: 999 }
    expect(response).to have_http_status(:ok)
  end
end
