class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: { scope: :post_id }

  after_create_commit :create_like_notification

  private

  def create_like_notification
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
