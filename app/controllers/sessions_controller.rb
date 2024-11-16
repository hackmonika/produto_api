class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = generate_token(user)
      render json: { token: token, message: "Login successful" }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def destroy
    render json: { message: "Logout successful" }, status: :ok
  end
end
