require 'rails_helper'

describe 'Book API', type: :request do
  it 'gets a list of all Books' do
    get '/api/v1/books'
    FactoryBot.create(:book, title: 'The Martian', author: 'Andy Weir')
    FactoryBot.create(:book, title: 'The Martian v2', author: 'Andy Weir')

    expect(response).to have_http_status(:ok)
    expect(response.body.size).to eq(2)
  end
end
