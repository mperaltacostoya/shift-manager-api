# == Schema Information
#
# Table name: shifts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  comments   :text             default("")
#  open       :boolean          default("true")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_shifts_on_user_id  (user_id)
#

require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
