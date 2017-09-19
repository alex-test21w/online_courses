require 'acceptance_helper'

RSpec.resource 'User takes part in courses', document: :v1 do
  header 'Accept', 'application/json'
  header 'X-Auth-Token', :jwt_token

  let(:user)         { create :user, course_users: course_user }
  let(:course_user)  { create_list(:course_user, 2, subscription: true) }
  let(:jwt_token)    { auth_token(user.id) }

  get '/api/v1/user/courses' do
    example 'Renders courses' do
      do_request

      expect(status).to eq 200

      expect(response_body).to eq(
        ActiveModel::Serializer::CollectionSerializer.new(user.participated_courses.recent,
        serializer: CourseWithoutAssociationsSerializer).to_json
      )
      expect(response_body).to match_schema('objects/course')
    end
  end
end
