FactoryBot.define do
	factory :comment do
			body {'comment'}
			association :user
			association :post
	end
end