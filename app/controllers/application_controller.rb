# frozen_string_literal: true

# Application controller
class ApplicationController < ActionController::API
  def not_found
    render json: { errors: 'Not found' }, status: :not_found
  end
end
