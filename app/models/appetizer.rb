class Appetizer < ApplicationRecord
  belongs_to :base_ingredient, class_name: 'Ingredient', foreign_key: 'base_ingredient_id'
  belongs_to :sub_ingredient, class_name: 'Ingredient', foreign_key: 'sub_ingredient_id'
  belongs_to :accent_ingredient, class_name: 'Ingredient', foreign_key: 'accent_ingredient_id'
  belongs_to :user
  belongs_to :alcohol

  validates :alcohol_id, :base_ingredient_id, :sub_ingredient_id, :accent_ingredient_id, presence: true
end
