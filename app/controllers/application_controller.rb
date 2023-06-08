# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordNotDestroyed, with: :render_not_destroyed_response

  private

  def render_not_found_response(err)
    render json: { error: err }, status: :not_found
  end

  def render_not_destroyed_response(err)
    render json: { errors: err }, status: :unprocessable_entity
  end
end
