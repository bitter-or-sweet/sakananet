FactoryBot.define do
	factory :appetizer do
		association :base_ingredient, factory: :ingredient
		association :sub_ingredient, factory: :ingredient
		association :accent_ingredient, factory: :ingredient
		association :user
		association :alcohol
	end
end