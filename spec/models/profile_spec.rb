require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { is_expected.to belong_to(:user) }
  it { should validate_presence_of :first_name }
end
