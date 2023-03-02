module TransactionHelper
  def transactions
    Transaction.where(source: self).or(Transaction.where(destination: self)).order(created_at: :desc)
  end

  def response
    as_json.merge(transactions: transactions.limit(10).order(created_at: :desc))
           .merge(debit_cards: user.debit_cards.without_authorization_code)
  end

  def make_credit(amount, source: nil, status: :pending, save: true, skip_source_validation: false) # rubocop:disable Lint/UnusedMethodArgument
    transaction = Transaction.new(amount:, source:, destination: self, transaction_type: :credit,
                                  status:)
    transaction.save! if save
    transaction
  end
end
