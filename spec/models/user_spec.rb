require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it 'passwordが3文字未満の場合、バリデーションが機能してinvalidになるか' do
      user = build(:user, password: "pa")
      expect(user).to be_invalid
      expect(user.errors.full_messages).to include("パスワードは3文字以上で入力してください")
    end

    it '名前が入力されていない場合、バリデーションが機能してinvalidになるか' do
      user = build(:user, name: nil)
      expect(user).to be_invalid
      expect(user.errors.full_messages).to include("名前を入力してください")
    end
  end
end
