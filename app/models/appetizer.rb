class Appetizer < ApplicationRecord
  belongs_to :base_ingredient, class_name: 'Ingredient', foreign_key: 'base_ingredient_id'
  belongs_to :sub_ingredient, class_name: 'Ingredient', foreign_key: 'sub_ingredient_id'
  belongs_to :accent_ingredient, class_name: 'Ingredient', foreign_key: 'accent_ingredient_id'
  has_many :alcohol_appetizers
  has_many :alcohols, through: :alcohol_appetizers
end
