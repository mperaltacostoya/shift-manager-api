class User < ApplicationRecord
  has_secure_password
  has_many :roles, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, :last_name, presence: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  def has_admin_role?
    self.roles&.where(role_type: 'admin').first.present?
  end

  def has_employee_role?
    self.roles&.where(role_type: 'employee').first.present?
  end

end
