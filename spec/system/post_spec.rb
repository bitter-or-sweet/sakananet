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
			expect(page).to have_content 'ログインしました'
			create(:alcohol_genre, genre: 'ビール')
			create(:appetizer_genre, genre: '和食')
		end

		describe '投稿新規作成' do
			context 'フォームの入力値が正常' do
				it '投稿の作成が成功する' do
					visit new_post_path
					fill_in 'タイトル', with: 'test_title'
					fill_in 'お酒', with: 'test_content'
					select 'ビール', from: 'post[alcohol_genre_id]'
					fill_in 'おつまみ', with: 'test_content'
					select '和食', from: 'post[appetizer_genre_id]'
					fill_in '感想（任意）', with: 'test_content'
					fill_in 'address', with: 'test_place'
					attach_file 'post[post_image]', File.join(Rails.root, 'spec/fixtures/images/test.jpg')
					click_button '投稿する'
					expect(page).to have_content '投稿を作成しました'
					expect(current_path).to eq posts_path
				end
			end

			context 'タイトルが未入力' do
				it '投稿の新規作成が失敗する' do
					visit new_post_path
					fill_in 'タイトル', with: ''
					fill_in 'お酒', with: 'test_content'
					select 'ビール', from: 'post[alcohol_genre_id]'
					fill_in 'おつまみ', with: 'test_content'
					select '和食', from: 'post[appetizer_genre_id]'
					click_button '投稿する'
					expect(page).to have_content '投稿を作成出来ませんでした'
					expect(page).to have_content 'タイトルを入力してください'
					expect(current_path).to eq new_post_path
				end
			end
		end

		describe '投稿編集' do
			let!(:post) { create(:post, user: user) }
			let(:other_post) { create(:post, user: user) }
			before { visit edit_post_path(post) }

			context 'フォームの入力値が正常' do
				it '投稿の編集が成功する' do
					fill_in 'タイトル', with: 'update_title'
					click_button '投稿する'
					expect(page).to have_content 'test_post'
					expect(page).to have_content 'お酒 ：test_post'
					expect(page).to have_selector('i.fa-solid.fa-wine-glass')
					expect(page).to have_content 'おつまみ ：test_post'
					expect(page).to have_selector('i.fa-solid.fa-utensils')
					expect(page).to have_content '投稿を更新しました'
					expect(current_path).to eq post_path(post)
				end
			end

			context 'タイトルが未入力' do
				it '投稿の編集が失敗する' do
					fill_in 'タイトル', with: nil
					click_button '投稿する'
					expect(page).to have_content '投稿を更新出来ませんでした'
					expect(page).to have_content 'タイトルを入力してください'
					expect(current_path).to eq edit_post_path(post)
				end
			end

			context '他ユーザーの投稿編集ページにアクセス' do
				let!(:other_user) { create(:other_user) }
				let!(:other_post) { create(:post, user: other_user) }

				it '編集ページへのアクセスが失敗する' do
					visit edit_post_path(other_post)
					expect(page).to have_content '投稿が見つかりません。'
					expect(current_path).to eq posts_path
				end
			end
		end

		describe '投稿削除' do
			let!(:post) { create(:post, user: user) }

			it '投稿の削除が成功する' do
				visit post_path(post)
				find('.fa-trash-can').click
				expect(page.accept_confirm).to eq '削除しますか？'
				expect(page).to have_content '投稿を削除しました'
				expect(current_path).to eq posts_path
				expect(page).not_to have_content post.title
			end
		end
	end
end