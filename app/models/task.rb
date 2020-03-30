class Task < ApplicationRecord
  validates :name, presence: true

  scope :name_like, -> (query) { where("name LIKE ?", "%#{ query }%") }
  scope :completed_like,  -> (query) { where('cast(completed as text) LIKE ?',  "#{ query }") }

  enum priority:{
    high: 0,
    middle: 1,
    low: 2
  }

  enum completed:{
    no_started: 0,
    in_progress: 1,
    completed: 2
  }
end
