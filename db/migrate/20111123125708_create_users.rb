class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :cell_phone_number
      t.string :email
      t.string :first_name
      t.string :language
      t.string :password_digest
      t.string :time_zone

      t.timestamps
    end
  end
end
