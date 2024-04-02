class ApplicationController < ActionController::Base
  include Pundit

  after_action :verify_authorized, unless: :devise_controller?
  after_action :verify_policy_scoped, unless: :devise_controller?
end
