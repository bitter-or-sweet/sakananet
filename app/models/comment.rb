class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :body, presence: true, length: { maximum: 100 }

  after_create_commit :create_comment_notification

  private

  def create_comment_notification
    return if self.user_id == self.post.user_id
    if self.post
      Notification.create(
        sender_id: self.user_id,
        recipient_id: self.post.user_id,
        notifiable: self
      )
    end
  end
end
