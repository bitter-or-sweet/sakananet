module UserHelper
  def display_user_avatar(user, class_options = 'rounded-[10px] h-10 w-10 border mr-2')
    avatar_url = user.avatar.present? ? user.avatar.url : 'default.jpg'
    image_tag(avatar_url, class: class_options)
  end
end