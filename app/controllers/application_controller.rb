class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordNotDestroyed, with: :render_not_destroyed_response

  private

  def render_not_found_response(e)
    render json: { error: e }, status: :not_found
  end

  def render_not_destroyed_response(e)
    render json: { errors: e }, status: :unprocessable_entity
  end
end
