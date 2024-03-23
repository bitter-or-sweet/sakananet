class LikesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    current_user.like(post)
    redirect_after_like(params[:return_to], post)
  end

  def destroy
    post = current_user.likes.find(params[:id]).post
    current_user.unlike(post)
    redirect_after_like(params[:return_to], post)
  end

  private

  def redirect_after_like(return_to, post)
    case return_to
    when 'index'
      redirect_to posts_path, notice: t('.success'), status: :see_other
    when 'show'
      redirect_to post_path(post), notice: t('.success'), status: :see_other
    when 'liked_index'
      redirect_to likes_posts_path, notice: t('.success'), status: :see_other
    end
  end
end