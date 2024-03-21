class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :set_post, only: %i[edit update destroy]

  def index
    @posts = Post.all.includes(:user).order(created_at: :desc)
  end

  def posted
    @posted_posts = current_user.posts
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
    @comments = @post.comments.includes(:user).order(created_at: :desc)
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

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :alcohol, :alcohol_genre_id, :appetizer, :appetizer_genre_id, :body, :post_image, :post_image_cache)
  end
end
