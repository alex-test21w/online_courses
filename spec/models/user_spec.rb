require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_one(:profile) }
  it { is_expected.to have_many(:social_profiles) }
  it { is_expected.to have_many(:homeworks) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:course_users) }
  it { is_expected.to have_many(:participated_courses) }

  specify do
    is_expected.to have_many(:authored_courses).
        with_foreign_key('user_id')
  end

  specify do
    is_expected.to have_many(:activities_for_me).
        with_foreign_key('recipient_id')
  end

  specify do
    is_expected.to have_many(:activities_from_me).
        with_foreign_key('owner_id')
  end

  describe 'destoys dependent authored_courses' do
    let(:user) { create :user }
    let!(:courses) { create_list :course, 2, user: user }

    specify do
      expect { User.last.destroy }.to change { Course.count }.by(-2)
    end
  end

  describe '#participate_in?' do
    let(:user)         { create :user }
    let(:course)       { create :course }
    let!(:course_user) { create :course_user, user: user, course: course }

    specify do
      expect(user.participate_in?(Course.last)).to eq true
    end
  end

  describe '#subscription_in?' do
    let(:user)         { create :user }
    let(:course)       { create :course }
    let!(:course_user) { create :course_user, user: user, course: course, subscription: true }

    context 'when user is participate' do
      specify do
        expect(user.participate_in?(Course.last)).to eq true
      end

      it 'when user is subscription' do
        expect(user.subscription_in?(Course.last)).to eq true
      end
    end
  end

  describe '#expel_in?' do
    let(:user)         { create :user }
    let(:course)       { create :course }
    let!(:course_user) { create :course_user, user: user, course: course, outcast: true }

    it 'when user is expelled from course' do
      expect(user.expel_in?(Course.last)).to eq true
    end
  end
end
