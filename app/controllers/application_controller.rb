class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  protected
  def admins_only
    redirect_to after_redirect_path, flash: { danger: 'Permission denied' } and return unless current_user.admin?
  end
end
