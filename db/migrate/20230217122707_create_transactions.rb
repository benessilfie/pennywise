class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :transaction_type, null: false
      t.decimal :amount, null: false, default: 0.0
      t.integer :status, null: false, default: 0
      t.references :source, polymorphic: true, index: true
      t.references :destination, polymorphic: true, index: true

      t.timestamps
    end
  end
end
