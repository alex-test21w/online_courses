require 'rails_helper'

RSpec.describe SocialProfile, type: :model do
  it { is_expected.to belong_to(:user) }
  it { should validate_presence_of :service_name }
  it { should validate_presence_of :uid }
  it { should validate_uniqueness_of(:service_name).scoped_to(:user_id) }
end
