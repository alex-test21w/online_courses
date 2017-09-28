require 'rails_helper'

RSpec.describe Homework, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:lesson) }
  it { should have_many(:comments) }
  it { should validate_presence_of :description }

  describe '#recent' do
    let!(:homework_1) { create :homework }
    let!(:homework_2) { create :homework }

    it 'should order courses by created_at DESC' do
      expect(Homework.recent).to eq [homework_2, homework_1]
    end
  end
end
