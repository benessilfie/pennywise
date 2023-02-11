class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :password_digest
      t.string :dob
      t.string :address
      t.string :auth_token

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
