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
  has_many :participated_courses, -> { where('course_users.subscription = ?', true) }, through: :course_users, source: :course
  has_many :activities_for_me,  class_name: 'Activity', foreign_key: :recipient_id
  has_many :activities_from_me, class_name: 'Activity', foreign_key: :owner_id

  before_save :ensure_authentication_token

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

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.exists?(authentication_token: token)
    end
  end
end
