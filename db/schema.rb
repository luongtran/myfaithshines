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

ActiveRecord::Schema.define(:version => 20130905161125) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "associate_producers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "site"
    t.text     "notes"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.float    "amount_owing"
    t.float    "amount_paid"
  end

  create_table "carts", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.date     "purchased_at"
  end

  create_table "codes", :force => true do |t|
    t.string   "code_value"
    t.integer  "sponsor_id"
    t.integer  "non_profit_id"
    t.integer  "total_value"
    t.integer  "redeem_value"
    t.integer  "redeemed"
    t.boolean  "active"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "associate_producer_id"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "dog_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "dogs", :force => true do |t|
    t.string   "name"
    t.integer  "gender_id"
    t.integer  "age"
    t.string   "home"
    t.text     "more"
    t.integer  "dog_type_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "month"
  end

  create_table "genders", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mail_messages", :force => true do |t|
    t.boolean  "all_users"
    t.boolean  "all_sponsors"
    t.boolean  "all_nonprofits"
    t.text     "addresses"
    t.text     "body"
    t.text     "other_mails"
    t.string   "subject"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "attachments"
    t.string   "cc"
    t.string   "bcc"
  end

  create_table "non_profit_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "non_profits", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "site"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "state_id"
    t.string   "snapshot_file_name"
    t.string   "snapshot_content_type"
    t.integer  "snapshot_file_size"
    t.datetime "snapshot_updated_at"
    t.boolean  "update_flag"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.boolean  "expanded"
    t.integer  "non_profit_type_id"
    t.string   "zipcode"
    t.float    "lat"
    t.float    "lng"
    t.string   "address"
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "status"
  end

  add_index "non_profits", ["reset_password_token"], :name => "index_non_profits_on_reset_password_token", :unique => true

  create_table "payment_notifications", :force => true do |t|
    t.text     "params"
    t.integer  "cart_id"
    t.string   "status"
    t.string   "transaction_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "payment_producers", :force => true do |t|
    t.date     "date"
    t.integer  "amount"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "associate_producer_id"
  end

  create_table "payments", :force => true do |t|
    t.float    "amount"
    t.string   "token"
    t.string   "identifier"
    t.integer  "non_profit_id"
    t.boolean  "recurring"
    t.boolean  "digital"
    t.boolean  "popup"
    t.boolean  "completed"
    t.boolean  "canceled"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "profit_sponsors", :force => true do |t|
    t.integer  "non_profit_id"
    t.integer  "sponsor_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "reservations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "x"
    t.integer  "y"
    t.integer  "width"
    t.integer  "height"
    t.integer  "non_profit_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "dog_id"
    t.integer  "room_option_id"
    t.string   "gift_codes"
    t.integer  "associate_producer_id"
    t.integer  "cart_id"
    t.float    "block_price"
    t.float    "total_price"
  end

  create_table "room_codes", :force => true do |t|
    t.integer  "room_id"
    t.integer  "code_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "room_options", :force => true do |t|
    t.integer  "width"
    t.integer  "height"
    t.float    "price"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rooms", :force => true do |t|
    t.integer  "x"
    t.integer  "y"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "user_id"
    t.integer  "dog_id"
    t.integer  "non_profit_id"
    t.integer  "associate_producer_id"
  end

  create_table "sold_blocks", :force => true do |t|
    t.integer  "amount"
    t.float    "compensation_due"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "associate_producer_id"
  end

  create_table "sponsors", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "site"
    t.integer  "state_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "featured"
    t.string   "category"
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "abbrev"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "zipcode"
    t.integer  "location_radius"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
