class Wallet < ApplicationRecord
  include TransactionHelper
  belongs_to :user

  validates :status, presence: true
  before_validation :check_status

  has_many :debit_transactions, as: :source, class_name: 'Transaction'
  has_many :credit_transactions, as: :destination, class_name: 'Transaction'

  enum status: { active: 0, inactive: 1 }

  def check_status
    self.status = :active unless status.present?
  end
end
