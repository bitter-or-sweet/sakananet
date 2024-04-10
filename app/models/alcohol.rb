class Alcohol < ApplicationRecord
  belongs_to :alcohol_genre

  validates :name, presence: true, length: { maximum: 30 }
end
