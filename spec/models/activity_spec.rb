require 'rails_helper'

RSpec.describe Activity, type: :model do
  it { is_expected.to belong_to(:trackable) }

  specify do
    should belong_to(:recipient).
        with_foreign_key('recipient_id')
  end

  specify do
    should belong_to(:owner).
        with_foreign_key('owner_id')
  end

  describe '#recent' do
    let!(:activity_1) { create :activity }
    let!(:activity_2) { create :activity }

    it 'should order courses by created_at DESC' do
      expect(Activity.recent).to eq [activity_2, activity_1]
    end
  end
end
