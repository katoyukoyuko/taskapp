FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    name { 'Factoryで作ったデフォルトのタイトル１' }
    description { 'Factoryで作ったデフォルトのコンテント１' }
    end_at { '2020-03-20 00:00:00' }
    completed { 'in_progress' }
    priority { 'high' }
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    name { 'Factoryで作ったデフォルトのタイトル２' }
    description { 'Factoryで作ったデフォルトのコンテント２' }
    end_at { '2020-03-21 00:00:00' }
    priority { 'middle'}
  end
end