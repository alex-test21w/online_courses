require 'rails_helper'

RSpec.describe ScheduleNewLessonNotificationWorker, type: :worker do
  it 'should run an worker when creating a lesson' do
    expect { create :lesson }.to change{ ScheduleNewLessonNotificationWorker.jobs.size }.by(1)
  end
end
