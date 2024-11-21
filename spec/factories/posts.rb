FactoryBot.define do
  factory :post do
    title {'test_post'}
    body {'test_post'}
    alcohol {'test_post'}
    appetizer {'test_post'}
    association :user
    association :alcohol_genre
    association :appetizer_genre
  end
end