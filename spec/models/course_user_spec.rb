require 'rails_helper'

RSpec.describe CourseUser, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:course) }
  it { should validate_uniqueness_of(:course_id).scoped_to(:user_id) }

  describe '#recent' do
    let!(:course_user_1) { create :course_user }
    let!(:course_user_2) { create :course_user }

    it 'should order course_users by created_at DESC' do
      expect(CourseUser.recent).to eq [course_user_2, course_user_1]
    end
  end

  describe '#not_outcast' do
    let!(:course_user_1) { create :course_user, outcast: true }
    let!(:course_user_2) { create :course_user, outcast: false }

    it 'show not outcast users' do
      expect(CourseUser.not_outcast).to match_array course_user_2
    end
  end
end
