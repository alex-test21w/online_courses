class User < ApplicationRecord
  rolify
  include Omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_one  :profile
  has_many :authored_courses, class_name: 'Course', foreign_key: :user_id, dependent: :destroy
  has_many :social_profiles
  has_many :homeworks

  has_many :course_users
  has_many :participated_courses, through: :course_users, source: :course

  delegate :first_name, :last_name, to: :profile, allow_nil: true

  accepts_nested_attributes_for :profile

  def participate_in?(course)
    course_users.exists?(course_id: course.id)
  end

  def subscription_in?(course)
    if participate_in?(course)
      course_users.where(course_id: course.id).first.subscription?
    end
  end

  def expel_in?(course)
    course_users.where(course_id: course.id).first.outcast?
  end
end
