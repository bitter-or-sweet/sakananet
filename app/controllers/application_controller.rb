class ApplicationController < ActionController::Base
  before_action :store_return_to
  before_action :require_login
  before_action :set_notification_objects
  include NotificationsHelper

  private

  def not_authenticated
    redirect_to login_path
  end

  def store_return_to
    session[:forwarding_url] = request.original_url if request.get?
  end

  def set_notification_objects
    @notifications = current_user.received_notifications.unread.order(create_at: :desc) if current_user
  end
end
