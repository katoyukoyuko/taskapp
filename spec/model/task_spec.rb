require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do
  before do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end

  it 'nameが空ならバリデーションが通らない' do
    task = Task.new(name: '', description: '失敗テスト')
    expect(task).not_to be_valid
  end
#   it 'descriptionが空ならバリデーションが通らない' do
#     # ここに内容を記載する
#   end
  it 'nameとdescriptionに内容が記載されていればバリデーションが通る' do
    task = Task.new(name: '失敗', description: '失敗テスト')
    expect(task).to be_valid
  end

  describe 'scope' do
    describe 'name_like' do
      it 'nameを入力し検索すると入力した内容のみ検索結果が表示される' do
        expect(Task.name_like('Factoryで作ったデフォルトのタイトル１').count).to eq 1
      end
    end
  end

  describe 'scope' do
    describe 'completed_like' do
      it 'completedを入力し検索すると入力した内容のみ検索結果が表示される' do
        expect(Task.completed_like('1').count).to eq 1
      end
    end
  end

  describe 'scope' do
    describe 'name_like' do
      describe 'completed_like' do
        it 'nameとcompletedを入力し検索すると入力した内容のみ検索結果が表示される' do
          expect(Task.name_like('Factoryで作ったデフォルトのタイトル１').completed_like('1').count).to eq 1
        end
      end
    end
  end

end