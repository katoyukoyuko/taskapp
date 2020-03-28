class Task < ApplicationRecord
  validates :name, presence: true

  scope :name_like, -> (query) { where("name LIKE ?", "%#{ query }%") }
  scope :completed_like,  -> (query) { where('cast(completed as text) LIKE ?',  "%#{query}%") }
  # scope :recent -> { name_like && completed_like }

end
