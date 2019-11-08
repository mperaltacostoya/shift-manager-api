class AuthenticationController < ApplicationController
  before_action :authorize_request, except: %i[login sign_up]

  # POST /auth/login
  def login
    @user = User.find_by_email(login_params[:email])
    if @user&.authenticate(login_params[:password])
      @token = JsonWebToken.encode(user_id: @user.id)
      @time = Time.now + 24.hours.to_i
      render status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  # POST /auth/signup
  def sign_up
    @user = User.new(signup_params)
    if @user.save
      @user.roles.create
      render status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def signup_params
    params.permit(
      :first_name, :last_name, :email, :password, :password_confirmation,
      :birthday, :address, :phone
    )
  end
end
