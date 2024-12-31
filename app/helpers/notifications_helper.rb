module NotificationsHelper
  def generate_notification_message(notification)
    return unless notification

    case notification.notifiable_type
    when 'Comment'
      "#{notification.sender.name} が #{generate_post_link(notification.notifiable.post)} にコメントしました".html_safe
    when 'Like'
      "#{notification.sender.name} が #{generate_post_link(notification.notifiable.post)} にいいね!しました".html_safe
    else
      '新規通知がありました'
    end
  end

  def generate_post_link(post)
    link_to post.title, post_path(post), class: "link", data: { turbo: false }
  end
end