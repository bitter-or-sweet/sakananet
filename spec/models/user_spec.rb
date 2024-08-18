require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      user = User.create(name: "tarou", email: "user@example.com", password: "password", password_confirmation: "password")
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end
  end
end
