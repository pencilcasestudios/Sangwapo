class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.references :user
      t.text :description
      t.string :panel_size
      t.string :listing_code
      t.string :uuid
      t.string :state

      t.timestamps
    end
    add_index :listings, :user_id
  end
end
