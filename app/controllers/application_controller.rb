class ApplicationController < ActionController::API
  set_current_tenant_through_filter
  before_action :authenticate_user
  before_action :handle_current_tenant

  private

  def authenticate_user
    token = request.headers["Authorization"].to_s.split(" ").last
    if token.blank?
      render_unauthorized("Token is missing")
      return
    end

    begin
      decoded_token = JWT.decode(token, Rails.application.credentials.development.devise_jwt_secret_key!, true, { algorithm: "HS256" })
      @current_user = User.find_by(id: decoded_token[0]["id"], jti: decoded_token[0]["jti"])
      if @current_user.nil?
        render_unauthorized("Invalid token")
      end
    rescue JWT::ExpiredSignature
      render_unauthorized("Token has expired. Please login again!")
    rescue JWT::DecodeError
      render_unauthorized("Invalid token")
    end
  end

  def current_user
    @current_user
  end

  def handle_current_tenant
    return nil unless current_user
    current_organization = current_user.organization
    set_current_tenant(current_organization)
  end

  def render_unauthorized(message)
    render json: { error: "Unauthorized", message: message }, status: :unauthorized
  end
end
