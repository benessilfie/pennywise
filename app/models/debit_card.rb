# frozen_string_literal: true

# DebitCard model
class DebitCard < ApplicationRecord
  belongs_to :user

  scope :without_authorization_code, -> { select(column_names - ['authorization_code']) }
end
