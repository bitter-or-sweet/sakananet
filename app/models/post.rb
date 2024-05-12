class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20 }
  validates :body, length: { maximum: 100 }
  validates :alcohol, presence: true, length: { maximum: 20 }
  validates :appetizer, presence: true, length: { maximum: 20 }

  belongs_to :user
  belongs_to :alcohol_genre
  belongs_to :appetizer_genre
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  mount_uploader :post_image, PostImageUploader

  geocoded_by :address
  after_validation :geocode

  def self.ransackable_attributes(auth_object = nil)
    ["title", "body", "alcohol", "appetizer"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "alcohol_genre", "appetizer_genre", "comments", "likes"]
  end
end
