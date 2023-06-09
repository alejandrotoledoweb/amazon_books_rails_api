require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  it 'should return a subset max of 100 book the limit is greater than 100' do
    expect(Book).to receive(:limit).with(100).and_call_original

    get :index, params: { limit: 999 }
    expect(response).to have_http_status(:ok)
  end

  context 'when token is not present' do
    it 'should return a 401 error when create is called' do
      post :create, params: {}

      expect(response).to have_http_status(:unauthorized)
    end
    it 'should return a 401 error when delete is called' do
      delete :destroy, params: { id: 1 }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
