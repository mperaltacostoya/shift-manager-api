# == Schema Information
#
# Table name: entries
#
#  id             :integer          not null, primary key
#  shift_id       :integer
#  comments       :text             default("")
#  entry_datetime :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  entry_type     :enum             default("check_in")
#
# Indexes
#
#  index_entries_on_shift_id  (shift_id)
#

require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
