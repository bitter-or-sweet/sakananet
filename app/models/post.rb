class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :alcohol, presence: true, length: { maximum: 255 }
  validates :appetizer, presence: true, length: { maximum: 255 }

  belongs_to :user
end
