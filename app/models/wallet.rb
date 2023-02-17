class Wallet < ApplicationRecord
  belongs_to :user

  validates :status, presence: true
  before_validation :check_status

  has_many :debit_transactions, as: :source, class_name: 'Transaction'
  has_many :credit_transactions, as: :destination, class_name: 'Transaction'

  enum status: { active: 0, inactive: 1 }

  def check_status
    self.status = :active unless status.present?
  end

  def transactions
    Transaction.where(source: self).or(Transaction.where(destination: self)).order(created_at: :desc)
  end

  def response
    as_json.merge(transactions: transactions.limit(10).order(created_at: :desc))
  end
end
