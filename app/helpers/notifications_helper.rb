module NotificationsHelper
  def generate_notification_message(notification)
    return unless notification

    case notification.notifiable_type
    when 'Comment'
      "#{notification.sender.name} が <strong>#{generate_post_link(post)}</strong> にコメントしました".html_safe
    when 'Like'
      "#{notification.sender.name} が <strong>#{generate_post_link(post)}</strong> にいいね!しました".html_safe
    else
      '新規通知がありました'
    end
  end

  def generate_post_link(post)
    link_to post.title, post_path(post)
  end
end