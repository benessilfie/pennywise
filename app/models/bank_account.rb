class BankAccount < ApplicationRecord
  has_many :transactions, as: :destination
end
