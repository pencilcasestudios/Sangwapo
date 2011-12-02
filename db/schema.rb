# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111202143537) do

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.string   "commentable_type"
    t.string   "label"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "listings", :force => true do |t|
    t.boolean  "exclude_price",                                :default => false
    t.datetime "approved_at"
    t.datetime "paid_at"
    t.decimal  "price",         :precision => 12, :scale => 2, :default => 0.0
    t.integer  "display_for",                                  :default => 5
    t.integer  "user_id"
    t.string   "currency"
    t.string   "listing_code"
    t.string   "listing_type"
    t.string   "panel_size"
    t.string   "price_option"
    t.string   "state"
    t.string   "uuid"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "listings", ["user_id"], :name => "index_listings_on_user_id"

  create_table "payments", :force => true do |t|
    t.datetime "received_at"
    t.integer  "listing_id"
    t.integer  "user_id"
    t.string   "from"
    t.string   "state"
    t.string   "to"
    t.string   "uuid"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["listing_id"], :name => "index_payments_on_listing_id"
  add_index "payments", ["user_id"], :name => "index_payments_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "cell_phone_number"
    t.string   "email"
    t.string   "first_name"
    t.string   "language"
    t.string   "password_digest"
    t.string   "role"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
