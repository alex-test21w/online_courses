require 'ffaker'

2.times.each do |n|
  @user = User.create!({
    email: FFaker::Internet.email,
    password: '111111',
    password_confirmation: '111111'
  })

  Profile.create!(
    first_name: FFaker::Name.first_name,
    last_name: FFaker::Name.last_name,
    user: @user
  )

  @user.add_role :trainer if n == 2

  puts "#{@user.first_name} #{@user.last_name} was created"
end

10.times.each do
  course = Course.create!({
    title: FFaker::Lorem.sentence(1),
    user: @user
  })

  puts "#{course.title} was created"
end

10.times.each do |n|
  lesson = Lesson.create({
    title: FFaker::Lorem.sentence(1),
    position: n,
    description: FFaker::Lorem.paragraphs,
    synopsis: FFaker::Lorem.paragraph,
    homework: FFaker::Lorem.paragraphs,
    start_date: Date.today + 3,
    course: Course.last
  })

  puts "#{lesson.title} was created"
end
