class Task < ApplicationRecord
  validates :title, presence: true
  belongs_to :user

  scope :is_completed, -> (completed) { where(completed: completed) }
end
