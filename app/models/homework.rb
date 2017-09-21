class Homework < ApplicationRecord
  include AASM

  scope :recent, -> { order(created_at: :desc) }

  belongs_to :user
  belongs_to :lesson

  has_many :comments, as: :commentable

  validates :description, presence: true

  aasm column: :state do
    state :pending, initial: true
    state :approved
    state :rejected

    event :approve, after_commit: :approve_homework do
      transitions to: :approved
    end

    event :reject, after_commit: :reject_homework do
      transitions to: :rejected
    end
  end

  private

  def approve_homework
    ApproveHomeworkNotificationWorker.perform_async(id)
  end

  def reject_homework
    RejectHomeworkNotificationWorker.perform_async(id)
  end
end
