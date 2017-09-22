# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
