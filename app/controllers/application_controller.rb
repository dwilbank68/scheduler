class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :layout_by_reference

  def after_sign_in_path_for(resource)
    units_path
  end

  def after_sign_up_path_for(resource)

  end

  protected

  def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:name, :email, :password) }
     devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :email2, :password, :password_confirmation, :phone, :phone2) }
     devise_parameter_sanitizer.for(:account_update).push(:avatar, :avatar_cache)
  end

  def layout_by_reference
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

end
