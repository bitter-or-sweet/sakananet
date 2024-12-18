FactoryBot.define do
  factory :user do
    name {'test_user'}
    sequence(:email) {|n| "test_#{n}@example.com"}
    password {'password'}
    password_confirmation {'password'}
  end

  factory :other_user, class: 'User' do
    name {'other_user'}
    sequence(:email) {|n| "test_#{n}@example2.com"}
    password {'password'}
    password_confirmation {'password'}
  end
end