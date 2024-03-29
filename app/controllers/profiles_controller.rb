class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: t('defaults.message.updated', item: t('activerecord.attributes.user.profile'))
    else
      flash.now['alert'] = t('defaults.message.not_updated', item: t('activerecord.attributes.user.profile'))
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name, :profile, :avatar, :avatar_cache)
  end
end