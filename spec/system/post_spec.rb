require 'rails_helper'

RSpec.describe 'Posts', type: :system do
	include LoginMacros
	let(:user) { create(:user) }
	let(:post) { create(:post) }

	describe 'ログイン前' do
		describe 'ページ遷移確認' do
			context '投稿の新規作成ページにアクセス' do
				it '新規作成ページへのアクセスが失敗する' do
					visit new_post_path
					expect(current_path).to eq login_path
				end
			end

			context '投稿の編集ページにアクセス' do
				it '編集ページへのアクセスが失敗する' do
					visit edit_post_path(post)
					expect(current_path).to eq login_path
				end
			end

			context '投稿の詳細ページにアクセス' do
				it '詳細ページへのアクセスが成功する' do
					visit post_path(post)
					expect(current_path).to eq post_path(post)
				end
			end

			context '投稿の一覧ページにアクセス' do
				it 'すべてのユーザーのタスク情報が表示される' do
					post_list = create_list(:post, 3)
					visit posts_path
					expect(page).to have_content post_list[0].title
					expect(page).to have_content post_list[1].title
					expect(page).to have_content post_list[2].title
					expect(current_path).to eq posts_path
				end
			end
		end
	end

	describe 'ログイン後' do
		before do
			login(user)
			create(:alcohol_genre, genre: 'ビール')
			create(:appetizer_genre, genre: '和食')
		end

		describe '投稿新規作成' do
			context 'フォームの入力値が正常' do
				it '投稿の作成が成功する' do
					sleep(0.1)
					visit new_post_path
					fill_in 'タイトル', with: 'test_title'
					fill_in 'お酒', with: 'test_content'
					select 'ビール', from: 'post[alcohol_genre_id]'
					fill_in 'おつまみ', with: 'test_content'
					select '和食', from: 'post[appetizer_genre_id]'
					fill_in '感想（任意）', with: 'test_content'
					fill_in 'address', with: 'test_place'
					click_button '投稿する'
					expect(page).to have_content '投稿を作成しました'
					expect(current_path).to eq posts_path
				end
			end
		end
	end
end