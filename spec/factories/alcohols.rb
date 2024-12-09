FactoryBot.define do
	factory :alcohol do
		name { "麦焼酎" }
		association :alcohol_genre
	end
end