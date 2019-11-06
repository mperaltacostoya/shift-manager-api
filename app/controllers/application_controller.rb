class ApplicationController < ActionController::API
  
  def not_found
    render json: { errors: 'Not found' }, status: :not_found
  end

  def authorize_request
    header = request.headers['Authorization']
    unless header.nil?
      header = header.split(' ').last
      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = User.where(id: @decoded[:user_id]).includes(:roles).first
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    else
      render json: { errors: 'Authorization header missing' }, status: :bad_request if header.nil?
    end
  end

  def authorize_admin
    unless @current_user.has_admin_role?
      render json: { errors: 'Missing permission' }, status: :forbidden
    end
  end

  def authorize_self_content
    unless @current_user.has_admin_role?
      if @current_user.id.to_s != params[:id]
        render json: { errors: 'Missing permission' }, status: :forbidden
      end
    end
  end
end
