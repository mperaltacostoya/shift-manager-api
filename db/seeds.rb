# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'running seed...'
User.all.destroy_all

admin = User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: 'admin@example.org',
  password: 'hello123',
  password_confirmation: 'hello123',
)

admin.roles.create(role_type: 'admin', role_name: 'Administrator')

# user creation
5.times do
  u = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.safe_email,
    address: Faker::Address.full_address,
    birthday: Faker::Date.between(from: 60.years.ago, to: 18.years.ago),
    phone: Faker::PhoneNumber.phone_number_with_country_code,
    password: 'hello123',
    password_confirmation: 'hello123',
  )
  # generate employee role
  u.roles.create

  # generate closed shifts
  5.times do |index|
    day = DateTime.now - (index + 1).days
    u.shifts.create(
      comments: Faker::Lorem.sentence,
      check_in_time: Faker::Time.between(from: day - 8.hours, to: day - 4.hours),
      check_out_time: Faker::Time.between(from: day - 4.hours, to: day)
    )
  end

  # generate an open shift
  u.shifts.create(
    comments: Faker::ChuckNorris.fact,
    check_in_time: Faker::Time.between(from: DateTime.now - 8.hours, to: DateTime.now - 4.hours)
  )

end

puts 'success'
