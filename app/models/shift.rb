# frozen_string_literal: true

# == Schema Information
#
# Table name: shifts
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  comments       :text             default("")
#  check_in_time  :datetime
#  check_out_time :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_shifts_on_user_id  (user_id)
#
class Shift < ApplicationRecord
  belongs_to :user

  validate :only_shift_open, on: :create
  validates :check_in_time, presence: true

  def open?
    check_out_time.blank?
  end

  private

  def only_shift_open
    last_open_shift = Shift.where(user_id: user_id, check_out_time: nil)
    errors.add(:base, 'User already has an open shift') if last_open_shift.present?
  end
end
