class ApplicationController < ActionController::Base
  before_action :store_return_to
  before_action :require_login

  private

  def not_authenticated
    redirect_to login_path
  end

  def store_return_to
    session[:forwarding_url] = request.original_url if request.get?
  end
end
