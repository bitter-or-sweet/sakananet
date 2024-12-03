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

  describe "アソシエーションチェック" do
    it "likeとuserが多対1の関係になっている" do
      expect(describe_class.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "likeとpostが多対1の関係になっている" do
      expect(describe_class.reflect_on_association(:post).macro).to eq(:belongs_to)
    end
  end
end