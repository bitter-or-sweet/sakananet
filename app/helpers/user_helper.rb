module UserHelper
  def user_avatar(user)
    avatar_url = user.avatar.present? ? user.avatar.url : 'default.jpg'
    image_tag(avatar_url, class: 'rounded-[10px] h-7 w-7 border mr-2')
  end
end