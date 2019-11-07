# == Schema Information
#
# Table name: shifts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  comments   :text
#  open       :boolean          default("true")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_shifts_on_user_id  (user_id)
#
class Shift < ApplicationRecord
  belongs_to :user
  has_many :entries, dependent: :destroy
end
