class Role < ApplicationRecord
  enum role_type: { employee: 'employee', admin: 'admin' }
end
