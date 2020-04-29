# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
    name: 'admin',
    email: 'admin@gmail.com',
    password: '000000',
    password_confirmation: '000000',
    admin: 'true',
    )

User.create!(
    name: 'name',
    email: 'name@gmail.com',
    password: '000000',
    password_confirmation: '000000',
    )

Task.create!(
    name: '風呂掃除',
    description: 'お風呂のカビ掃除をする。',
    end_at: '2020-04-30 00:00:00',
    completed: 'no_started',
    priority: 'middle',
    user_id: 1,
)

Task.create!(
    name: '洗濯',
    description: '洗濯をする。',
    end_at: '2020-04-30 00:00:00',
    completed: 'no_started',
    priority: 'high',
    user_id: 2,
)

Task.create!(
    name: '企画書作成',
    description: '仕事の企画書作成をする。',
    end_at: '2020-05-10 00:00:00',
    completed: 'no_started',
    priority: 'middle',
    user_id: 2,
)

Label.create!(
    name: '仕事',
)
Label.create!(
    name: '家事',
)

Label.create!(
    name: 'ママ',
)

Label.create!(
    name: 'パパ',
)

Labelling.create!(
    task_id: 1,
    label_id: 2,
)

Labelling.create!(
    task_id: 2,
    label_id: 2,
)

Labelling.create!(
    task_id: 3,
    label_id: 1,
)

Labelling.create!(
    task_id: 1,
    label_id: 3,
)

Labelling.create!(
    task_id: 2,
    label_id: 4,
)

Labelling.create!(
    task_id: 3,
    label_id: 4,
)