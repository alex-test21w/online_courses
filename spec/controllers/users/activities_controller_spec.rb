require 'rails_helper'

RSpec.describe Users::ActivitiesController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in(user) }

  describe '#index' do
    let(:activity)    { create(:activity, recipient: user) }

    specify do
      expect(assigns(:activities)).to eq Activity.last
    end
  end
end
