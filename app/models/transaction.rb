class Transaction < ApplicationRecord
  belongs_to :source, polymorphic: true
  belongs_to :destination, polymorphic: true

  validates :transaction_type, presence: true
  validates :amount, presence: true
  validates :status, presence: true

  enum transaction_type: { credit: 0, debit: 1 }
  enum status: { pending: 0, success: 1, failed: 2, cancelled: 3 }
end
