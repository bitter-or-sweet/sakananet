require 'rails_helper'

RSpec.describe Ingredient, type: :model do
	describe 'バリデーションチェック' do
		it '設定したバリデーションが機能しているか' do
			ingredient = build(:ingredient)
			expect(ingredient).to be_valid
			expect(ingredient.errors).to be_empty
		end

		it 'nameが入力されていない場合は無効' do
			ingredient = build(:ingredient, name: nil)
			expect(ingredient).to be_invalid
			expect(ingredient.errors.full_messages).to include("食材の名前を入力してください")
		end

		it 'nameが30文字を超える場合は無効' do
			ingredient = build(:ingredient, name: "a" * 31)
			expect(ingredient).to be_invalid
			expect(ingredient.errors.full_messages).to include("食材の名前は30文字以内で入力してください")
		end
	end

	describe 'アソシエーションチェック' do
		it { is_expected.to have_many(:appetizers_as_base) }
		it { is_expected.to have_many(:appetizers_as_sub) }
		it { is_expected.to have_many(:appetizers_as_accent) }
	end
end