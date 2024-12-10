require 'rails_helper'

RSpec.describe Appetizer, type: :model do
	describe 'バリデーションチェック' do
		it '設定したバリデーションが機能しているか' do
			appetizer = create(:appetizer)
			expect(appetizer).to be_valid
			expect(appetizer.errors).to be_empty
		end

		it 'base_ingredient_idが設定されていない場合は無効' do
			appetizer = build(:appetizer, base_ingredient_id: nil)
			expect(appetizer).to be_invalid
			expect(appetizer.errors.full_messages).to include("Base ingredientを入力してください")
		end

		it 'sub_ingredient_idが設定されていない場合は無効' do
			appetizer = build(:appetizer, sub_ingredient_id: nil)
			expect(appetizer).to be_invalid
			expect(appetizer.errors.full_messages).to include("Sub ingredientを入力してください")
		end

		it 'accent_ingredient_idが設定されていない場合は無効' do
			appetizer = build(:appetizer, accent_ingredient_id: nil)
			expect(appetizer).to be_invalid
			expect(appetizer.errors.full_messages).to include("Accent ingredientを入力してください")
		end

		it 'alcohol_idが設定されていない場合は無効' do
			appetizer = build(:appetizer, alcohol_id: nil)
			expect(appetizer).to be_invalid
			expect(appetizer.errors.full_messages).to include("Alcoholを入力してください")
		end
	end

	describe 'アソシエーションチェック' do
		it { is_expected.to belong_to(:base_ingredient) }
		it { is_expected.to belong_to(:sub_ingredient) }
		it { is_expected.to belong_to(:accent_ingredient) }
		it { is_expected.to belong_to(:user) }
		it { is_expected.to belong_to(:alcohol) }
	end
end