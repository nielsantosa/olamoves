class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_params, if: :devise_controller?

  protected

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :photo])
  end
end

# def configure_permitted_parameters
#   devise_parameter_sanitizer.permit(:sign_up) do |user_params|
#     user_params.permit({ roles: ['instructor', 'yogi'] }, :email, :password, :name)
#   end
# end
