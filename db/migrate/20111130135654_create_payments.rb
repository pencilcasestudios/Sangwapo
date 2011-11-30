class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.datetime :received_at
      t.references :listing
      t.references :user
      t.string :from
      t.string :to
      t.string :uuid
      t.text :notes

      t.timestamps
    end
    add_index :payments, :user_id
    add_index :payments, :listing_id
  end
end
