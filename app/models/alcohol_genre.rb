class AlcoholGenre < ApplicationRecord
  has_many :posts
  has_many :alcohols

  validates :genre, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "genre", "id", "updated_at"]
  end
end
