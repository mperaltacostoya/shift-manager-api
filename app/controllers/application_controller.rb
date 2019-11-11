# frozen_string_literal: true

# Application controller
class ApplicationController < ActionController::API
  def not_found
    render json: { errors: 'Not found' }, status: :not_found
  end

  def authorize_request
    header = request.headers['Authorization']
    if header.nil?
      return render json: { errors: 'Authorization header missing' }, status: :bad_request
    end

    header = header.split(' ').last
    begin
      decoded = JsonWebToken.decode(header)
      unless decoded && decoded[:user_id].present?
        return render json: { errors: 'Invalid token' }, status: :unauthorized
      end

      @current_user = User.includes(:roles).find(decoded[:user_id])
    rescue StandardError
      return render json: { errors: 'Authentication failed' }, status: :unauthorized
    end
  end

  def authorize_admin
    unless @current_user.admin_role?
      render json: { errors: 'Missing permission' }, status: :forbidden
    end
  end

  def authorize_self_content
    unless @current_user.admin_role?
      if params[:user_id].present? || params[:id].present?
        user_id = params[:user_id].present? ? params[:user_id] : params[:id]
        if @current_user.id.to_s != user_id
          return render json: { errors: 'Missing permission' }, status: :forbidden
        end
      end
    end
  end
end
