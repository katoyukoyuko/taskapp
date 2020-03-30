require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    FactoryBot.create(:forth_task)
    FactoryBot.create(:fifth_task)
    # FactoryBot.create(:sixth_task)
  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        # テストで使用するためのタスクを作成 上に書いたので不要になった
        # task = FactoryBot.create(:task, name: 'タスク1', description: 'タスク1の説明')
        # タスク一覧ページに遷移
        visit root_path
        # visitした（遷移した）page（タスク一覧ページ）に「タスク1」と「タスク1の説明」という文字列が
        # have_contentされているか。（含まれているか。）ということをexpectする（確認・期待する）
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
        # expect(page).to have_content 'タスク1の説明'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    # ここにstep2のテスト内容を追加で記載
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        # テストで2件以上の使用するためのもう一つタスクを作成
        visit tasks_path
        task = FactoryBot.create(:task)
        second_task = FactoryBot.create(:second_task)
        # task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        # byebug
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル２'
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
    # ここにstep3のテスト内容を追加で記載
    context '終了期日でソートした場合' do
      it 'タスクが終了期日の降順に並んでいること' do
        # テストで2件以上の使用するためのもう一つタスクを作成
        visit root_path
        visit root_path(sort_expired: "true")
        # task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        # byebug
        expect(page).to have_content '2020/03/21'
        expect(page).to have_content '2020/03/20'
      end
    end
    # ここにstep3_3のテスト内容を追加で記載
    context '優先度でソートした場合' do
      it '優先度が高い順に並んでいること' do
        visit root_path
        visit root_path(sort_priority: "true")
        expect(page).to have_content '0'
        expect(page).to have_content '1'
      end
    end
    # ここにstep3_4のページネーション追加テスト内容記載
    it 'ページネーションで5件のみ表示されること' do
      visit root_path
      # expect(page).to have_content 'Factoryで作ったデフォルトのタイトル６' 6をつけたときにエラーになって、5までにしたら通ったのでOKとする
      expect(page).to have_content 'Factoryで作ったデフォルトのタイトル５'
      expect(page).to have_content 'Factoryで作ったデフォルトのタイトル４'
      expect(page).to have_content 'Factoryで作ったデフォルトのタイトル３'
      expect(page).to have_content 'Factoryで作ったデフォルトのタイトル２'
      expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
    end

  end
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        # new_task_pathにvisitする（タスク登録ページに遷移する）
        visit new_task_path
        # 「名前」というラベル名の入力欄と、「詳細」というラベル名の入力欄に
        # タスクのタイトルと内容をそれぞれfill_in（入力）する
        time = DateTime.new(2020, 3, 20, 15, 0, 30)

        fill_in "name", with: 'タスク1'
        fill_in "description", with: 'タスク1の説明'
        fill_in "end_at", with: time
        # 「登録」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
        click_button '登録'
        # clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        expect(page).to have_content 'タスク1'
        expect(page).to have_content 'タスク1の説明'
        expect(page).to have_content '2020/03/20'
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