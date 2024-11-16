class UsersController < ApplicationController
  protect_from_forgery with: :null_session

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: "User was created successfully!", user: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
