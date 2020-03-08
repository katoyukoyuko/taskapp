require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, name: 'タスク1', description: 'タスク1の説明')
        # タスク一覧ページに遷移
        visit root_path
        # visitした（遷移した）page（タスク一覧ページ）に「タスク1」と「タスク1の説明」という文字列が
        # have_contentされているか。（含まれているか。）ということをexpectする（確認・期待する）
        expect(page).to have_content 'タスク1'
        expect(page).to have_content 'タスク1の説明'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        # new_task_pathにvisitする（タスク登録ページに遷移する）
        visit new_task_path
        # 「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄に
        # タスクのタイトルと内容をそれぞれfill_in（入力）する
        fill_in 'Name', with: 'タスク1'
        fill_in 'Description', with: 'タスク1の説明'
        # 「Create Task」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
        click_button 'Create Task'
        # clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        expect(page).to have_content 'タスク1'
        expect(page).to have_content 'タスク1の説明'   
      end
    end
  end
  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示されたページに遷移すること' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, name: 'タスク1', description: 'タスク1の説明')
        # タスク詳細ページに遷移
        visit task_path(task.id)
        # visitした（遷移した）page（タスク詳細ページ）に「タスク1」と「タスク1の説明」という文字列が
        # have_contentされているか。（含まれているか。）ということをexpectする（確認・期待する）
        expect(page).to have_content 'タスク1'
        expect(page).to have_content 'タスク1の説明'
       end
     end
  end
end