class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

  def generate_token(user)
    payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, SECRET_KEY, "HS256")
  end

  def authenticate_user
    token = request.headers["Authorization"]&.split(" ")&.last
    return render json: { error: "Unauthorized" }, status: :unauthorized unless token

    decoded_token = JWT.decode(token, SECRET_KEY, true, { algorithm: "HS256" }) rescue nil
    @current_user = User.find_by(id: decoded_token&.dig(0, "user_id"))
    render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
  end
end
