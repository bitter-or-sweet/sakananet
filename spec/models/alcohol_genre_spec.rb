require 'rails_helper'

RSpec.describe AlcoholGenre, type: :model do
	describe 'バリデーションチェック' do
		it '設定したバリデーションが機能しているか' do
			alcohol_genre = build(:alcohol_genre)
			expect(alcohol_genre).to be_valid
			expect(alcohol_genre.errors).to be_empty
		end

		it 'genreが入力されていない場合は無効' do
			genre = build(:alcohol_genre, genre: nil)
			expect(genre).to be_invalid
			expect(genre.errors.full_messages).to include("お酒のジャンルを入力してください")
		end
	end

	describe 'アソシエーションチェック' do
		it { is_expected.to have_many(:posts) }
		it { is_expected.to have_many(:alcohols) }
	end
end