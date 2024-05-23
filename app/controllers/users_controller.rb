class UsersController < ApplicationController
  skip_before_action :store_return_to, only: %i[new show]
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(user_params[:email], user_params[:password])
      redirect_to root_path, notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @alcohol_genre_counts = Post.joins(:alcohol_genre).where(user_id: params[:id]).group('alcohol_genres.genre').count
    @appetizer_genre_counts = Post.joins(:appetizer_genre).where(user_id: params[:id]).group('appetizer_genres.genre').count
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :avatar_cache)
  end
end