# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  birthday        :datetime
#  address         :string
#  phone           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

# frozen_string_literal: true
class User < ApplicationRecord
  has_secure_password
  has_many :roles, dependent: :destroy
  has_many :shifts, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, :last_name, presence: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  def admin_role?
    roles&.where(role_type: 'admin').first.present?
  end

  def employee_role?
    roles&.where(role_type: 'employee').first.present?
  end
end
