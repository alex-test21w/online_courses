class Activity < ApplicationRecord
  KIND_HOMEWORK_APPROVED = 'approved'
  KIND_HOMEWORK_REJECTED = 'rejected'

  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
  belongs_to :owner,     class_name: 'User', foreign_key: :owner_id
  belongs_to :trackable, polymorphic: true

  scope :recent, -> { order(created_at: :desc) }
end
