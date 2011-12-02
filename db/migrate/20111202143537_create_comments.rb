class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commentable_id
      t.references :user
      t.string :commentable_type
      t.string :label
      t.text :body

      t.timestamps
    end
    add_index :comments, :user_id
  end
end
