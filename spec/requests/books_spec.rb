require "rails_helper"

RSpec.describe "Book API", type: :request do
  describe "GET /books" do
    let(:author) do
      FactoryBot.create(:author, first_name: "Andy", last_name: "Weir", age: 55)
    end
    let(:author2) do
      FactoryBot.create(
        :author,
        first_name: "Andres",
        last_name: "Paredes",
        age: 45
      )
    end

    it "gets a list of all Books" do
      FactoryBot.create(:book, title: "The Martian", author: author)
      FactoryBot.create(
        :book,
        title: "Programming Ruby 1.9 & 2.0",
        author: author2
      )
      get "/api/v1/books"

      expect(response).to have_http_status(:ok)
      expect(response_body.size).to eq(2)
    end

    it "should return a subset of books based on pagination using limit" do
      FactoryBot.create(:book, title: "The Martian", author: author)
      FactoryBot.create(
        :book,
        title: "Programming Ruby 1.9 & 2.0",
        author: author2
      )
      get "/api/v1/books", params: { limit: 1 }
      # p api_v1_books_path <-- to find this path you run: rails routes | books --> api_v1_books GET /api/v2/books(.:format) api/v2/books#index
      # the path will be the first column of the output of the command above with the prefix of the controller: api_v1_books_path or api_v2_books_url
      expect(response).to have_http_status(:ok)
      expect(response_body.size).to eq(1)
    end

    it "should return a subset of books based on pagination using limit and offset" do
      book = FactoryBot.create(:book, title: "The Martian", author: author)
      book2 =
        FactoryBot.create(
          :book,
          title: "Programming Ruby 1.9 & 2.0",
          author: author2
        )
      get "/api/v1/books", params: { limit: 1, offset: 1 }

      expect(response).to have_http_status(:ok)
      expect(response_body).to eq(
        [
          {
            "author_age" => 45,
            "author_first_name" => "Andres",
            "author_last_name" => "Paredes",
            "author_name" => "Andres Paredes",
            "id" => book2.id,
            "title" => "Programming Ruby 1.9 & 2.0"
          }
        ]
      )

      expect(response_body).not_to eq(
        [
          {
            "author_age" => 55,
            "author_first_name" => "Weir",
            "author_last_name" => "Weir",
            "author_name" => "Weir Weir",
            "id" => book.id,
            "title" => "The Martian"
          }
        ]
      )
    end
  end

  describe "POST /books" do
    let!(:author) do
      FactoryBot.create(:author, first_name: "Andy", last_name: "Weir", age: 55)
    end
    it "creates a new book" do
      expect {
        post "/api/v1/books",
             params: {
               book: {
                 title: "The Pragmatic Programmer",
                 author_id: author.id
               }
             }
      }.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(response.body).to include("The Pragmatic Programmer")
    end
  end

  describe "DELETE /books/:id" do
    let!(:author) do
      FactoryBot.create(:author, first_name: "Andy", last_name: "Weir", age: 55)
    end
    it "deletes a book" do
      book =
        FactoryBot.create(
          :book,
          title: "Programming Ruby 1.9 & 5.0",
          author_id: author.id
        )
      expect { delete "/api/v1/books/#{book.id}" }.to change {
        Book.count
      }.from(1).to(0)
      expect(response).to have_http_status(:no_content)
    end
  end
end
