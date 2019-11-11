# frozen_string_literal: true

# Shift controller: Define CRUD methods for shifts
class ShiftsController < ApplicationController
  before_action :authorize_request
  before_action :authorize_admin, except: %i[index show]
  before_action :authorize_self_content, only: :index
  before_action :set_shift, except: %i[create index]
  before_action :set_user, only: :create

  # GET /shifts
  # GET /users/{user_id}/shifts
  def index
    if !@current_user.admin_role? && !params[:user_id].present?
      render json: { errors: 'Missing permission' }, status: :forbidden
    end
    @shifts = Shift.all
    @shifts.where!(user_id: params[:user_id]) if params[:user_id].present?
    @shifts = paginate @shifts.page(params[:page])
  end

  # GET /shifts/{id}
  def show
    if !@current_user.admin_role? && @shift.user_id != @current_user.id
      render json: { errors: 'Missing permission' }, status: :forbidden
    end
  end

  # POST /users/{user_id}/shifts
  def create
    @shift = @user.shifts.new(shift_params)
    if @shift.save
      render json: { message: 'Shift successfully created' }, status: :created
    else
      render json: { errors: @shift.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /shifts/{id}
  def update
    unless @shift.update(shift_params)
      render json: { errors: @shift.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /shifts/{id}
  def destroy
    unless @shift.destroy
      render json: { errors: @shift.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def set_shift
    @shift = Shift.find_by(id: params[:id])
  end

  def shift_params
    params.permit(
      :user_id, :comments, :check_in_time, :check_out_time
    )
  end
end
