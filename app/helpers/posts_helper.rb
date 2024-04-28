module PostsHelper
  def display_post_image(post)
    image_url = post.post_image? ? post.post_image.url : 'post_placeholder.png'
    link_to post_path(post) do
      image_tag(image_url)
    end
  end

  def display_like_button(current_user, post)
    return unless current_user.present? && !current_user.own?(post)
    render 'like_button', post: post
  end
end