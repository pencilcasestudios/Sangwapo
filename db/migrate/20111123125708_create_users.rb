class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.datetime :cell_phone_number_verified_at
      t.datetime :email_verified_at
      t.string :cell_phone_number
      t.string :cell_phone_number_verification_token
      t.string :email
      t.string :email_verification_token
      t.string :first_name
      t.string :language
      t.string :password_digest
      t.string :role
      t.string :state
      t.string :time_zone

      t.timestamps
    end
  end
end
