module PostsHelper
  def display_post_image(post)
    image_url = post.post_image? ? post.post_image.url : 'post_placeholder.png'
    link_to post_path(post) do
      image_tag(image_url)
    end
  end

  def display_like_button(post)
    return unless logged_in?
    render 'like_button', post: post
  end
end