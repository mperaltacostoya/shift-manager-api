class AuthenticationController < ApplicationController
  before_action :authorize_request, except: %i[login sign_up]

  # POST /auth/login
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime('%m-%d-%Y %H:%M'),
                     username: @user.email }, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  # POST /auth/signup
  def sign_up
    @user = User.new(user_params)
    if @user.save
      @user.roles.create
      render json: { message: 'User successfully registered' }, status: :created
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
