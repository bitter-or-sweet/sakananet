class UserSessionsController < ApplicationController
  skip_before_action :store_return_to
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password], params[:remember_me])
    if @user
      redirect_to(session[:return_to] || root_path, notice: t('.success'))
      session[:return_to] = nil
    else
      flash.now[:alert] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    remember_me!
    forget_me!
    logout
    redirect_to root_path, status: :see_other, notice: t('.success')
  end
end