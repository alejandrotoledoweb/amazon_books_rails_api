module Api
  module V1
    class BooksController < ApplicationController
      include ActionController::HttpAuthentication::Token

      MAX_PAGINATION_LIMIT = 100

      before_action :authenticate_user, only: %i[create destroy]
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
        # Example of creation of a Job
        # CreateBookJob.perform_later(book_params)
      end

      def destroy
        Book.find(params[:id]).destroy!
        head :no_content
      end

      private

      def authenticate_user
        # Authorization: 'Bearer <token>'
        # binding.irb
        token, _options = token_and_options(request)
        user_id = AuthenticationTokenService.decode(token)
        User.find(user_id)
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError
        render status: :unauthorized
      end

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
