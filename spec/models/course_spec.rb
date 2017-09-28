require 'rails_helper'

RSpec.describe Course, type: :model do
  it { is_expected.to belong_to(:user) }
  it { should have_many(:course_users) }
  it { should have_many(:participants) }
  it { should have_many(:lessons) }
  it { should validate_presence_of :title }
  it { should validate_length_of(:title).is_at_most(100) }

  describe '#recent' do
    let!(:course_1) { create :course }
    let!(:course_2) { create :course }

    it 'should order courses by created_at DESC' do
      expect(Course.recent).to eq [course_2, course_1]
    end
  end

  describe '#visible' do
    let!(:course_1) { create :course, active: true }
    let!(:course_2) { create :course, active: false }

    it 'show active courses' do
      expect(Course.visible).to match_array course_1
    end
  end

  describe 'lesson_positions' do
    let(:course) { create(:course) }
    let!(:lessons) { create_list(:lesson, 2, course: course) }

    it 'should check count of lessons' do
      expect(course.lesson_positions).to eq 3
    end
  end

  describe 'destoys dependent lessons' do
    let!(:lesson) { create :lesson }

    specify do
      expect { Course.last.destroy }.to change { Lesson.count }.by(-1)
    end
  end

  describe 'show participants of course' do
    let(:course)          { create :course }
    let!(:not_subscribed) { create :course_user, course: course, subscription: false }
    let!(:subscription)   { create :course_user, course: course, subscription: true }

    specify do
      expect(Course.last.participants.size).to eq 1
    end
  end
end
