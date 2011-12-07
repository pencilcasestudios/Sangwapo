class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.datetime :received_at
      t.decimal :amount, precision: 12, scale: 2, default: 0
      t.references :listing
      t.references :user
      t.string :from
      t.string :method
      t.string :state
      t.string :to
      t.string :uuid
      t.text :notes

      t.timestamps
    end
    add_index :payments, :user_id
    add_index :payments, :listing_id
  end
end
