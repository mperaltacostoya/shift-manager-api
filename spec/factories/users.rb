FactoryBot.define do
  factory :user, class: User do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.safe_email }
    address { Faker::Address.full_address }
    birthday { Faker::Date.between(from: 60.years.ago, to: 18.years.ago) }
    phone { Faker::PhoneNumber.phone_number_with_country_code }
    password { 'hello123' }
    password_confirmation { 'hello123' }

    factory :employee_user do
      after(:create) do |user|
        create(:employee_role, user: user)
      end
    end

    factory :employee_user_with_open_shift do
      after(:create) do |user|
        create_list(:closed_shift, 5, user: user)
        create(:open_shift, user: user)
      end
    end

    factory :employee_user_with_shifts do
      after(:create) do |user|
        create_list(:closed_shift, 6, user: user)
      end
    end

    factory :admin_user do
      after(:create) do |user|
        create(:admin_role, user: user)
      end
    end  
  end

end