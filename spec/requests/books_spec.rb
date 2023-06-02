require 'rails_helper'

describe 'Book API', type: :request do

  describe 'GET /books' do

    it 'gets a list of all Books' do
      author = FactoryBot.create(:author, first_name: 'Andy', last_name: 'Weir')
      FactoryBot.create(:book, title: 'The Martian', author: author)
      FactoryBot.create(:book, title: 'Programming Ruby 1.9 & 2.0', author: author)
      get '/api/v1/books'

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /books' do
    let!(:author) { FactoryBot.create(:author, first_name: 'Andy', last_name: 'Weir', age: 55) }
    it 'creates a new book' do
      expect {
        post '/api/v1/books', params: { book: { title: 'The Pragmatic Programmer', author_id: author.id } }
        p response
      }.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(response.body).to include('The Pragmatic Programmer')
    end
  end

  describe 'DELETE /books/:id' do
    let!(:author) { FactoryBot.create(:author, first_name: 'Andy', last_name: 'Weir', age: 55) }
    it 'deletes a book' do
      book =  FactoryBot.create(:book, title: 'Programming Ruby 1.9 & 5.0', author_id: author.id)
      expect {
        delete "/api/v1/books/#{book.id}"
    }.to change { Book.count }.from(1).to(0)
      expect(response).to have_http_status(:no_content)
    end
  end
end
