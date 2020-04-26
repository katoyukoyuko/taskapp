require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do
    before do
        # あらかじめユーザーのテストで使用するためのユーザーを作成する
        @user = create(:user)
        @admin_user = create(:admin_user)
    end

    describe 'ユーザー登録画面' do
        context '必要項目を入力して、createボタンを押した場合' do
            it 'データが保存されること' do
            visit new_user_path
            fill_in "user[name]", with: 'test'
            fill_in "user[email]", with: 'test@test.com'
            fill_in "user[password]", with: '123456'
            fill_in "user[password_confirmation]", with: '123456'
            # 「登録」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
            click_button '登録'
            # clickで登録されたはずの情報が、ユーザー詳細ページに表示されているかを確認する
            expect(page).to have_content 'test'
            expect(page).to have_content 'test@test.com'
            end
        end
        context '未ログインで、タスク一覧のページに遷移した場合' do
            it 'ログイン画面に遷移すること' do
            visit root_path
            # expect(page).to have_selector 'h1', text: 'ログイン'
            expect(current_path).to eq new_session_path
            end
        end
    end

    describe 'セッション機能' do
        context '必要項目を入力して、ログインボタンを押した場合' do
            it 'ログインができ、ユーザー詳細画面に遷移すること' do
            visit new_session_path
            fill_in "session[email]", with: 'admin@example.com'
            fill_in "session[password]", with: '00000000'
            click_button 'ログイン'
            expect(page).to have_content 'admin'
            expect(page).to have_content 'admin@example.com'
            end
        end

        context '一般ユーザが他人の詳細画面に遷移しようとした場合' do
            it 'タスク一覧ページに遷移すること' do
            visit new_session_path
            fill_in "session[email]", with: 'sample@example.com'
            fill_in "session[password]", with: '00000000'
            click_button 'ログイン'
            visit user_path(@admin_user.id)
            expect(current_path).to eq root_path
            end
        end

        context 'ログアウトボタンをクリックした場合' do
            it 'ログアウトできること' do
            visit new_session_path
            fill_in "session[email]", with: 'sample@example.com'
            fill_in "session[password]", with: '00000000'
            click_button 'ログイン'
            click_link 'Logout'
            expect(current_path).to eq new_session_path
            expect(page).to have_content 'ログアウトしました'
            end
        end
    end

    describe 'ユーザー管理画面' do
        context '管理者である場合' do
            it '管理画面にアクセスできること' do
            visit new_session_path
            fill_in "session[email]", with: 'admin@example.com'
            fill_in "session[password]", with: '00000000'
            click_button 'ログイン'
            visit admin_users_path
            expect(page).to have_selector 'h1', text: 'ユーザー一覧'
            end
        end

        context '一般ユーザーである場合' do
            it '管理画面にアクセスできないこと' do
            visit new_session_path
            fill_in "session[email]", with: 'sample@example.com'
            fill_in "session[password]", with: '00000000'
            click_button 'ログイン'
            visit admin_users_path
            expect(current_path).to eq root_path
            expect(page).to have_content 'あなたは管理者ではありません'
            end
        end

        context '管理者である場合' do
            it 'ユーザを新規登録できること' do
            visit new_session_path
            fill_in "session[email]", with: 'admin@example.com'
            fill_in "session[password]", with: '00000000'
            click_button 'ログイン'
            visit new_admin_user_path
            fill_in "user[name]", with: 'test'
            fill_in "user[email]", with: 'test@test.com'
            fill_in "user[password]", with: '123456'
            fill_in "user[password_confirmation]", with: '123456'
            # 「登録」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
            click_button '登録'
            expect(page).to have_content 'ユーザーを作成しました'
            end
        end

        context '管理者である場合' do
            it 'ユーザの詳細画面にアクセスできること' do
            visit new_session_path
            fill_in "session[email]", with: 'admin@example.com'
            fill_in "session[password]", with: '00000000'
            click_button 'ログイン'
            visit edit_admin_user_path(@user.id)
            fill_in "user[name]", with: 'test'
            fill_in "user[password]", with: '00000000'
            fill_in "user[password_confirmation]", with: '00000000'
            # 「登録」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
            click_button '登録'
            expect(page).to have_content 'test'
            end
        end

        context '管理者である場合' do
            it 'ユーザの削除ができること' do
            visit new_session_path
            fill_in "session[email]", with: 'admin@example.com'
            fill_in "session[password]", with: '00000000'
            click_button 'ログイン'
            visit admin_users_path
            page.accept_confirm do  
                click_on '削除', match: :first  
            end
            expect(page).to have_content 'ユーザーを削除しました'
            end
        end
    end
end