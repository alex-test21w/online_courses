require 'rails_helper'

RSpec.describe ApproveHomeworkNotificationWorker, type: :worker do
  let(:homework) { create :homework, state: 'rejected' }

  it 'should run an worker when homework is approved' do
    expect { homework.approve! }.to change{ ApproveHomeworkNotificationWorker.jobs.size }.by(1)
  end
end
