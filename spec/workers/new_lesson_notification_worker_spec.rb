require 'rails_helper'

RSpec.describe NewLessonNotificationWorker, type: :worker do
  let(:lesson) { create :lesson }
  let(:user)   { create :user }

  specify do
    expect {
      NewLessonNotificationWorker.perform_async(lesson.id, user.id)
    }.to change(NewLessonNotificationWorker.jobs, :size).by(1)
  end
end
