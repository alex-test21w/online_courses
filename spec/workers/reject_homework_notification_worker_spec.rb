require 'rails_helper'

RSpec.describe RejectHomeworkNotificationWorker, type: :worker do
  let(:homework) { create :homework, state: 'approved' }

  it 'should run an worker when homework is rejected' do
    expect { homework.reject! }.to change{ RejectHomeworkNotificationWorker.jobs.size }.by(1)
  end
end
