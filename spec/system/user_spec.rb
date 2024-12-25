require 'rails_helper'

RSpec.describe 'Users', type: :system do
  include LoginMacros
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }

  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する' do
          visit new_user_path
          fill_in '名前', with: 'name'
          fill_in 'メールアドレス', with: 'email@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          attach_file 'user[avatar]', File.join(Rails.root, 'spec/fixtures/images/test.jpg')
          click_button '新規登録'
          expect(page).to have_content 'ユーザー登録が完了しました'
          expect(current_path).to eq root_path
        end
      end

      context '名前が未入力' do
        it 'ユーザーの新規登録が失敗する' do
          visit new_user_path
          fill_in '名前', with: ''
          fill_in 'メールアドレス', with: 'email@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '新規登録'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content '名前を入力してください'
          expect(current_path).to eq new_user_path
        end
      end

      context 'メールアドレスが未入力' do
        it 'ユーザーの新規登録が失敗する' do
          visit new_user_path
          fill_in '名前', with: 'name'
          fill_in 'メールアドレス', with: ''
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '新規登録'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content 'メールアドレスを入力してください'
          expect(current_path).to eq new_user_path
        end
      end

      context '登録済みのメールアドレスを使用' do
        it 'ユーザーの新規登録が失敗する' do
          existed_user = create(:user)
          visit new_user_path
          fill_in '名前', with: 'name'
          fill_in 'メールアドレス', with: existed_user.email
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '新規登録'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content 'メールアドレスはすでに存在します'
          expect(current_path).to eq new_user_path
          expect(page).to have_field 'メールアドレス', with: existed_user.email
        end
      end
    end

    describe 'マイページ' do
      context 'ログインしていない状態' do
        it 'マイページへのアクセスが失敗する' do
          visit user_path(user)
          expect(current_path).to eq login_path
        end
      end
    end

    describe 'プロフィールページ' do
      context 'ログインしていない状態' do
        it 'プロフィールページへのアクセスに失敗する' do
          visit user_path(user)
          expect(current_path).to eq login_path
        end
      end
    end
  end

  describe 'ログイン後' do
    describe 'プロフィールページ' do
      context 'ログインしている状態' do
        it 'プロフィールページへのアクセスが成功する' do
          login(user)
          expect(page).to have_content 'ログインしました'
          visit user_path(other_user)
          expect(current_path).to eq user_path(other_user)
        end
      end
    end
  end
end