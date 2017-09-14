class Homework < ApplicationRecord
  include AASM

  scope :recent, -> { order(created_at: :desc) }

  belongs_to :user
  belongs_to :lesson

  validates :description, presence: true

  aasm column: :state do
    state :pending, initial: true
    state :approved
    state :rejected

    event :approve do
      transitions to: :approved
    end

    event :reject do
      transitions to: :rejected
    end
  end
end
