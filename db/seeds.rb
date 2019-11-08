# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.all.destroy_all

admin = User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: 'admin@example.org',
  password: 'hello123',
  password_confirmation: 'hello123',
)

admin.roles.create(role_type: 'admin', role_name: 'Administrator')

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
  u.roles.create

  2.times do |index|
    shift = u.shifts.create(open: false, comments: Faker::Lorem.sentence)
    day = DateTime.now - (index + 1).days
    shift.entries.create(
      entry_datetime: Faker::Time.between(from: day - 8.hours, to: day - 4.hours),
      comments: Faker::ChuckNorris.fact
    )
    shift.entries.create(
      entry_type: 'check_out',
      entry_datetime: Faker::Time.between(from: day - 4.hours, to: day)
    )
  end

  open_shift = u.shifts.create
  open_shift.entries.create(
    entry_datetime: Faker::Time.between(
      from: DateTime.now - 8.hours,
      to: DateTime.now - 4.hours
    ),
    comments: Faker::ChuckNorris.fact
  )
end
