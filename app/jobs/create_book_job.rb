class CreateBookJob < ApplicationJob
  queue_as :default

  def perform(book_params)
    book = Book.new(book_params)

    if book.save
      render json: book, status: :created
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end
end
