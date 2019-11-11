# frozen_string_literal: true

FactoryBot.define do
  factory :open_shift, class: Shift do
    comments { Faker::Lorem.sentence }
    check_in_time { Faker::Time.between(from: DateTime.now - 8.hours, to: DateTime.now - 4.hours) }
  end

  factory :closed_shift, class: Shift do
    comments { Faker::Lorem.sentence }
    check_in_time { Faker::Time.between(from: DateTime.now - 8.hours, to: DateTime.now - 4.hours) }
    check_out_time { Faker::Time.between(from: DateTime.now - 4.hours, to: DateTime.now) }
  end
end
