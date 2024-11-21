require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it 'passwordが3文字未満の場合は無効' do
      user = build(:user, password: "pa")
      expect(user).to be_invalid
      expect(user.errors.full_messages).to include("パスワードは3文字以上で入力してください")
    end

    it 'password_confirmationが入力されていない場合は無効' do
      user = build(:user, password_confirmation: nil)
      expect(user).to be_invalid
      expect(user.errors.full_messages).to include("パスワード確認を入力してください")
    end

    it 'nameが入力されていない場合は無効' do
      user = build(:user, name: nil)
      expect(user).to be_invalid
      expect(user.errors.full_messages).to include("名前を入力してください")
    end

    it 'nemeが10文字を超える場合は無効' do
      user = build(:user, name: "aaabbbcccddd")
      expect(user).to be_invalid
      expect(user.errors.full_messages).to include("名前は10文字以内で入力してください")
    end

    it 'emailが入力されていない場合は無効' do
      user = build(:user, email: nil)
      expect(user).to be_invalid
      expect(user.errors.full_messages).to include("メールアドレスを入力してください")
    end

    it 'emailが重複した場合は無効' do
      user1 = create(:user, email: "user@example.com")
      user2 = build(:user, email: user1.email)
      expect(user2).to be_invalid
      expect(user2.errors.full_messages).to include("メールアドレスはすでに存在します")
    end
  end
end
