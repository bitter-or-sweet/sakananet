require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      post = build(:post)
      expect(post).to be_valid
      expect(post.errors).to be_empty
    end

    it 'titleが入力されていない場合は無効' do
      post = build(:post, title: nil)
      expect(post).to be_invalid
      expect(post.errors.full_messages).to include("タイトルを入力してください")
    end

    it 'titleが20文字を超える場合は無効' do
      post = build(:post, title: "a"*21)
      expect(post).to be_invalid
      expect(post.errors.full_messages).to include("タイトルは20文字以内で入力してください")
    end

    it 'bodyが100文字を超える場合は無効' do
      post = build(:post, body: "a"*101)
      expect(post).to be_invalid
      expect(post.errors.full_messages).to include("本文は100文字以内で入力してください")
    end

    it 'alcoholが入力されていない場合は無効' do
      post = build(:post, alcohol: nil)
      expect(post).to be_invalid
      expect(post.errors.full_messages).to include("お酒を入力してください")
    end

    it 'alcoholが20文字を超える場合は無効' do
      post = build(:post, alcohol: "a"*21)
      expect(post).to be_invalid
      expect(post.errors.full_messages).to include("お酒は20文字以内で入力してください")
    end

    it 'appetizerが入力されていない場合は無効' do
      post = build(:post, appetizer: nil)
      expect(post).to be_invalid
      expect(post.errors.full_messages).to include("おつまみを入力してください")
    end

    it 'appetizerが20文字を超える場合は無効' do
      post = build(:post, appetizer: "a"*21)
      expect(post).to be_invalid
      expect(post.errors.full_messages).to include("おつまみは20文字以内で入力してください")
    end
  end
end