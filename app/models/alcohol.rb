class Alcohol < ApplicationRecord
  belongs_to :alcohol_genre
  has_many :alcohol_appetizers
  has_many :appetizers

  validates :name, presence: true, length: { maximum: 30 }
end
