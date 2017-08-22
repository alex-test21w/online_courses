require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should validate_presence_of :title }
  it { should validate_length_of(:title).is_at_most(20) }

  describe '#recent' do
    let!(:course_1) { create :course }
    let!(:course_2) { create :course }

    it 'should order courses by created_at DESC' do
      expect(Course.recent).to eq [course_2, course_1]
    end
  end
end
