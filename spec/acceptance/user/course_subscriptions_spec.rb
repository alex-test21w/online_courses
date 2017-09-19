require 'acceptance_helper'

RSpec.resource 'Course subscription', document: :v1 do
  header 'Accept', 'application/json'
  header 'X-Auth-Token', :jwt_token

  let(:user)        { create :user }
  let(:jwt_token)   { auth_token(user.id) }
  let!(:course_user) { create(:course_user, course: course_2, user: user) }

  let!(:course_1) { create(:course) }
  let!(:course_2) { create(:course) }

  post '/api/v1/user/course_subscriptions' do
    parameter :course_id,   'course id',   required: true

    let(:course_id) { course_1.id }

    example 'Subscription' do
      do_request

      expect(status).to eq 201

      expect(response_body).to eq({
                                     'data': 'You have successfully subscribed to the course'
                                  }.to_json)
    end

    context 'When cant subscribe to the course' do
      let(:course_id) { course_2.id }

      example 'Сant subscribe' do
        do_request

        expect(status).to eq 403

        expect(response_body).to eq({
                                       'error': { 'message': 'You have already been subscribed to the course' }
                                    }.to_json)
      end
    end
  end
end
