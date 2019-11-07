# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  role_name  :string           default("Employee")
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role_type  :enum             default("employee")
#
# Indexes
#
#  index_roles_on_user_id  (user_id)
#

require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
