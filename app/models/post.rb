class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :alcohol, presence: true, length: { maximum: 255 }
  validates :appetizer, presence: true, length: { maximum: 255 }

  belongs_to :user
  belongs_to :alcohol_genre
  belongs_to :appetizer_genre
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  mount_uploader :post_image, PostImageUploader

  def self.ransackable_attributes(auth_object = nil)
    ["title", "body", "alcohol", "appetizer"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "alcohol_genre", "appetizer_genre", "comments", "likes"]
  end
end
