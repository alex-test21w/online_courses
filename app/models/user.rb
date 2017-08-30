class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile
  has_many :courses, dependent: :destroy

  delegate :first_name, :last_name, to: :profile, allow_nil: true

  accepts_nested_attributes_for :profile
end
