class Ingredient < ApplicationRecord
  has_many :appetizers_as_base, class_name: 'Appetizer', foreign_key: 'base_ingredient_id'
  has_many :appetizers_as_sub, class_name: 'Appetizer', foreign_key: 'sub_ingredient_id'
  has_many :appetizers_as_accent, class_name: 'Appetizer', foreign_key: 'accent_ingredient_id'
  validates :name, presence: true, length: { maximum: 30 }
end
