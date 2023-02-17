class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount, null: false, default: 0.0
      t.integer :status, null: false, default: 0
      t.integer :transaction_type, null: false
      t.string :transaction_reference, null: false, unique: true, index: true
      t.references :source, polymorphic: true, null: false, index: true
      t.references :destination, polymorphic: true, null: false, index: true

      t.timestamps
    end
  end
end
