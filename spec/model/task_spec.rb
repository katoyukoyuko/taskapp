require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :model do
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
end