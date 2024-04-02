# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, if: :devise_controller?

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def configure_sign_in_params
    # Permit the `organisation_id` parameter along with other sign-up parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      videos_path
    else
      user_session_path
    end
  end

  def after_sign_out_path_for(resource)
    user_session_path
  end
end
