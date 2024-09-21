require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  describe "バリデーションチェック" do
    it "設定した全てのバリデーションが機能しているか" do
      like = create(:like, user: user, post: post)
      expect(like).to be_valid
    end

    it "ユーザーが投稿に2回いいねした場合は無効" do
      create(:like, user: user, post: post)
      duplicate_like = build(:like, user: user, post: post)
      expect(duplicate_like).to be_invalid
      expect(duplicate_like.errors[:user_id]).to include("はすでに存在します")
    end
  end
end