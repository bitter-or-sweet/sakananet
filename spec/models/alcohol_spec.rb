require 'rails_helper'

RSpec.describe Alcohol, type: :model do
	describe 'バリデーションチェック' do
		it '設定したバリデーションが機能しているか' do
			alcohol = build(:alcohol)
			expect(alcohol).to be_valid
			expect(alcohol.errors).to be_empty
		end

		it 'nameが入力されていない場合は無効' do
			alcohol = build(:alcohol, name: nil)
			expect(alcohol).to be_invalid
			expect(alcohol.errors.full_messages).to include("お酒の名前を入力してください")
		end

		it 'nameが30文字を超える場合は無効' do
			alcohol = build(:alcohol, name: 'a' * 31)
			expect(alcohol).to be_invalid
			expect(alcohol.errors.full_messages).to include("お酒の名前は30文字以内で入力してください")
		end
	end
end