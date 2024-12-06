require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーションチェック' do
		it '設定したバリデーションが機能しているか' do
			comment = build(:comment)
			expect(comment).to be_valid
			expect(comment.errors).to be_empty
		end

		it 'bodyが入力されていない場合は無効' do
			comment = build(:comment, body: nil)
			expect(comment).to be_invalid
			expect(comment.errors.full_messages).to include("コメントを入力してください")
		end

		it 'bodyが100文字を超える場合は無効' do
			comment = build(:comment, body: "a"*101)
			expect(comment).to be_invalid
			expect(comment.errors.full_messages).to include("コメントは100文字以内で入力してください")
		end
	end

	describe 'アソシエーションチェック' do
		it { is_expected.to belong_to(:user) }
		it { is_expected.to belong_to(:post) }
	end
end