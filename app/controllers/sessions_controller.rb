class SessionsController < ApplicationController
  require "jwt"

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = generate_token(user)
      render json: { token: token }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def generate_token(user)
    payload = { user_id: user.id }
    JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS256')
  end
end
