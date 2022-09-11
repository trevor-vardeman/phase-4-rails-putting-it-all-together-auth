class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_logged_in_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_not_logged_in_response

  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    if current_user
      render json: current_user, status: :ok
    else
      render json: { error: "No active session" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation, :image_url, :bio)
  end

  def render_not_logged_in_response
    render json: { error: "You are not logged in." }, status: :unauthorized
  end

end