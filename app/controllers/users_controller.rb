class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: { message: "User created successfully", user: user.as_json(only: [ :id, :name, :email ]) }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /users/:id
  def show
    user = User.find(params[:id])
    render json: user, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
