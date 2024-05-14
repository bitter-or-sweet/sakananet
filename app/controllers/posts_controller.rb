class PostsController < ApplicationController
  skip_before_action :store_return_to, only: %i[index posted show]
  skip_before_action :require_login, only: %i[index show]
  before_action :set_post, only: %i[edit update destroy]

  def index
    if params[:user_id]
      # 特定のユーザーの投稿をフィルタリング
      user_posts = Post.where(user_id: params[:user_id])
      @q = user_posts.ransack(params[:q])
    else
      # 全ての投稿を検索対象とする
      @q = Post.ransack(params[:q])
    end
    @posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def posted
    @q = current_user.posts.ransack(params[:q])
    @posted_posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
    @alcohol_genres = AlcoholGenre.all
    @appetizer_genres = AppetizerGenre.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: t('defaults.message.created', item: Post.model_name.human)
    else
      flash.now['alert'] = t('defaults.message.not_created', item: Post.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :asc)
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t('defaults.message.updated', item: Post.model_name.human)
    else
      flash.now[:alert] = t('defaults.message.not_updated', item: Post.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, notice: t('defaults.message.deleted', item: Post.model_name.human), status: :see_other
  end

  def likes
    @q = current_user.like_posts.ransack(params[:q])
    @like_posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :alcohol, :alcohol_genre_id, :appetizer, :appetizer_genre_id, :body, :address, :post_image, :post_image_cache)
  end
end
