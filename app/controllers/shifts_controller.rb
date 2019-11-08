# frozen_string_literal: true
class ShiftsController < ApplicationController
  before_action :authorize_request
  before_action :authorize_admin, except: %i[index show]
  before_action :authorize_self_content, only: :index

  before_action :find_shift, except: %i[create index]
  # before_action :authorize_self_shift

  # GET /shifts
  def index
    if !@current_user.admin_role? && !params[:user_id].present?
      render json: { errors: 'Missing permission' }, status: :forbidden
    end
    @shifts = Shift.all.includes(:entries)
    @shifts.where!(user_id: params[:user_id]) if params[:user_id].present?
  end

  # GET /shifts/{id}
  def show
    if !@current_user.admin_role? && @shift.user_id != @current_user.id
      render json: { errors: 'Missing permission' }, status: :forbidden
    end
  end

  # POST /shifts
  def create
    @shift = User.new(user_params)
    if @shift.save
      @shift.roles.create
      render json: { message: 'User successfully created' }, status: :created
    else
      render json: { errors: @shift.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /shifts/{id}
  def update
    unless @shift.update(user_params)
      render json: { errors: @shift.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /shifts/{id}
  def destroy
    @shift.destroy
  end

  private

  def find_shift
    @shift = Shift.includes(:entries).find_by(id: params[:id])
  end

  def shift_params
    params.permit(
      :first_name, :last_name, :email, :password, :password_confirmation,
      :birthday, :address, :phone
    )
  end
end
