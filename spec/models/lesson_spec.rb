require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it { is_expected.to belong_to(:course) }
  it { should have_many(:homeworks) }
  it { should have_many(:activities) }
  it { should have_many(:comments) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :position }
  it { should validate_presence_of :start_date }


  describe '#order_by_position' do
    let!(:lesson_1) { create :lesson, position: 2 }
    let!(:lesson_2) { create :lesson, position: 1 }

    it 'should order lessons by position ASC' do
      expect(Lesson.order_by_position).to eq [lesson_2, lesson_1]
    end
  end
end
