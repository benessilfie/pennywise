class Transaction < ApplicationRecord
  belongs_to :source, polymorphic: true
  belongs_to :destination, polymorphic: true

  attr_accessor :skip_source_validation, :skip_destination_validation

  validates :source, presence: true, unless: :skip_source_validation
  validates :destination, presence: true, unless: :skip_destination_validation
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true
  validates :transaction_type, presence: true
  validates :transaction_reference, presence: true, uniqueness: true

  enum transaction_type: { credit: 0, debit: 1 }
  enum status: { pending: 0, success: 1, failed: 2, cancelled: 3 }

  before_validation :set_transaction_reference, on: :create

  def set_transaction_reference
    self.transaction_reference = SecureRandom.hex(10)
  end

  def user = source ? source.user : destination&.user
end
