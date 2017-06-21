class Contact < ApplicationRecord
  belongs_to :user

  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  validates :phone, length: { maximum: 20 }
  validates :address, length: { maximum: 255 }
  validates :organization, length: { maximum: 100 }
  VALID_DATE_REGEX = /(\d){4}-\d{2}-\d{2}/
  validates :birthday, length: { maximum: 10 }, format: { with: VALID_DATE_REGEX }, allow_nil: true

  # Email Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
    format: { with: VALID_EMAIL_REGEX }, uniqueness: { 
      case_sensitive: false, scope: [:user_id, :email] }
end
