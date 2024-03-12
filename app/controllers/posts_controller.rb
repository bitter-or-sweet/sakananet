class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  def index
    @posts = Post.all.includes(:user).order(created_at: :desc)
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

  private

  def post_params
    params.require(:post).permit(:title, :alcohol, :alcohol_genre_id, :appetizer, :appetizer_genre_id, :body)
  end
end
