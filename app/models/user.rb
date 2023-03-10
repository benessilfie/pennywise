class User < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'must be a valid email address' }
  validates :password, presence: true, length: { minimum: 8, message: 'must be at least 8 characters' }

  has_secure_password
  has_one :wallet, dependent: :destroy
  has_many :debit_cards, dependent: :destroy

  after_create :create_wallet, if: proc { |user| user.wallet.nil? }
end
