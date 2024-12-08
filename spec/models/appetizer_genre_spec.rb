require 'rails_helper'

RSpec.describe AppetizerGenre, type: :model do
	describe 'バリデーションチェック' do
		it '設定したバリデーションが機能しているか' do
			appetizer_genre = build(:appetizer_genre)
			expect(appetizer_genre).to be_valid
			expect(appetizer_genre.errors).to be_empty
		end

		it 'genreが入力されていない場合は無効' do
			appetizer_genre = build(:appetizer_genre, genre: nil)
			expect(appetizer_genre).to be_invalid
			expect(appetizer_genre.errors.full_messages).to include("おつまみのジャンルを入力してください")
		end
	end
end