# frozen_string_literal: true

FactoryBot.define do
  factory :admin_role, class: Role do
    role_type { 'admin' }
    role_name { 'Administrator' }
  end

  factory :employee_role, class: Role do
    role_type { 'employee' }
    role_name { 'Employee' }
  end
end
