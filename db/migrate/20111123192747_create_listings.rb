class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.boolean :exclude_price, default: false
      t.datetime :approved_at
      t.datetime :paid_at
      t.decimal :price, precision: 12, scale: 2, default: 0
      t.integer :display_for
      t.references :user
      t.string :currency
      t.string :listing_code
      t.string :listing_type
      t.string :panel_size
      t.string :price_option
      t.string :state
      t.string :uuid
      t.text :description

      t.timestamps
    end
    add_index :listings, :user_id
  end
end
