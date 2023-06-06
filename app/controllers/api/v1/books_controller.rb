module Api
  module V1
    class BooksController < ApplicationController
      MAX_PAGINATION_LIMIT = 100

      def index
        books = Book.limit(max_limit).offset(params[:offset])
        render json: BooksRepresenter.new(books).as_json
      end

      def create
        book = Book.new(book_params)

        if book.save
          render json: book, status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def destroy
        Book.find(params[:id]).destroy!
        head :no_content
      end

      private

      def book_params
        params.require(:book).permit(:title, :author_id)
      end

      def max_limit
        [
          params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i,
          MAX_PAGINATION_LIMIT
        ].min
      end
    end
  end
end
