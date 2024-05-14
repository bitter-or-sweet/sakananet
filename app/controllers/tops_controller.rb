class TopsController < ApplicationController
  skip_before_action :store_return_to, only: %i[terms_of_use, privacy_policy]
  skip_before_action :require_login
  def index; end

  def terms_of_use; end

  def privacy_policy; end
end
