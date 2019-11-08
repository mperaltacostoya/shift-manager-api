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
#
class Entry < ApplicationRecord
  belongs_to :shift
  enum entry_type: { check_in: 'check_in', check_out: 'check_out' }
end
