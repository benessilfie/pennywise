class Wallet < ApplicationRecord
  belongs_to :user
  validates :status, presence: true
  before_validation :check_status

  enum status: { active: 0, inactive: 1 }

  def check_status
    self.status = :active unless status.present?
  end
end
