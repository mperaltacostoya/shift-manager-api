# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorize_request
  before_action :authorize_admin, except: :show
  before_action :authorize_self_content, only: :show
  before_action :set_user, except: %i[create index]

  # GET /users
  def index
    @users = paginate User.all.includes(:roles).where(roles: { role_type: 'employee' })
  end

  # GET /users/{id}
  def show; end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      @user.roles.create
      render status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{id}
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/{id}
  def destroy
    unless @user.destroy
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :first_name, :last_name, :email, :password, :password_confirmation,
      :birthday, :address, :phone
    )
  end
end
