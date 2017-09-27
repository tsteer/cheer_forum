class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  protected

  def not_current_user
    redirect_to login_path, flash: { danger: 'You must be logged in to do this' } and return unless current_user
  end
  
  def admins_only
    redirect_to after_redirect_path, flash: { danger: 'Permission denied' } and return unless current_user.admin?
  end
end
