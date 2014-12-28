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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141228181241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin", force: true do |t|
    t.text     "name"
    t.string   "email",                     limit: 320,              null: false
    t.string   "encrypted_password",                    default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "default_price_customer_id"
  end

  add_index "admin", ["email"], name: "index_admin_on_email", unique: true, using: :btree
  add_index "admin", ["reset_password_token"], name: "index_admin_on_reset_password_token", unique: true, using: :btree

  create_table "campaign", force: true do |t|
    t.integer  "status"
    t.text     "text"
    t.datetime "init"
    t.integer  "customer_id"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "campaign", ["customer_id"], name: "index_campaign_on_customer_id", using: :btree
  add_index "campaign", ["list_id"], name: "index_campaign_on_list_id", using: :btree

  create_table "column_list", force: true do |t|
    t.string   "name"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "type"
    t.boolean  "key",        default: false
  end

  add_index "column_list", ["list_id"], name: "index_column_list_on_list_id", using: :btree

  create_table "contact", force: true do |t|
    t.string   "number"
    t.json     "data"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contact", ["list_id"], name: "index_contact_on_list_id", using: :btree

  create_table "currency", force: true do |t|
    t.text  "sign"
    t.text  "name"
    t.text  "code"
    t.float "value_convert"
  end

  create_table "customer", force: true do |t|
    t.text     "name"
    t.string   "email",                  limit: 320,                null: false
    t.float    "credit"
    t.integer  "type_pay"
    t.integer  "customer_id"
    t.integer  "type_customer_id"
    t.integer  "admin_id"
    t.integer  "currency_id"
    t.integer  "price_customer_id"
    t.string   "encrypted_password",                 default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "active",                             default: true
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.text     "confirmation_token"
    t.string   "unconfirmed_email"
  end

  add_index "customer", ["email"], name: "index_customer_on_email", unique: true, using: :btree
  add_index "customer", ["price_customer_id"], name: "index_customer_on_price_customer_id", using: :btree
  add_index "customer", ["reset_password_token"], name: "index_customer_on_reset_password_token", unique: true, using: :btree

  create_table "list", force: true do |t|
    t.string   "name"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "map",         default: true
  end

  add_index "list", ["customer_id"], name: "index_list_on_customer_id", using: :btree

  create_table "outgoing", force: true do |t|
    t.integer  "admin_id"
    t.integer  "customer_id"
    t.datetime "at"
    t.integer  "duration"
    t.integer  "provider_id"
    t.integer  "route_id"
    t.float    "cost"
    t.text     "destination"
    t.text     "ip"
    t.text     "hangupcause"
    t.integer  "price_customer_id"
    t.integer  "currency_id"
    t.float    "price_for_customer"
    t.text     "status"
    t.text     "code"
    t.text     "response"
    t.integer  "list_id"
    t.integer  "campaign_id"
    t.integer  "contact_id"
    t.text     "text"
  end

  add_index "outgoing", ["at", "admin_id"], name: "idx_at_admin_on_call", using: :btree
  add_index "outgoing", ["at", "customer_id"], name: "idx_at_customer_on_call", using: :btree
  add_index "outgoing", ["campaign_id"], name: "index_outgoing_on_campaign_id", using: :btree
  add_index "outgoing", ["contact_id"], name: "index_outgoing_on_contact_id", using: :btree
  add_index "outgoing", ["list_id"], name: "index_outgoing_on_list_id", using: :btree

  create_table "price_customer", force: true do |t|
    t.text    "name"
    t.float   "percent_recharge"
    t.integer "admin_id"
  end

  create_table "protocol", force: true do |t|
    t.text "name"
  end

  create_table "provider", force: true do |t|
    t.text    "name"
    t.text    "email"
    t.integer "admin_id"
    t.float   "balance"
    t.integer "priority"
    t.integer "status"
    t.text    "from_user"
    t.text    "host"
    t.text    "username"
    t.text    "password"
    t.integer "protocol_id"
  end

  create_table "rate", force: true do |t|
    t.integer "provider_id"
    t.integer "route_id"
    t.integer "priority"
    t.float   "price"
  end

  create_table "rate_customer", force: true do |t|
    t.integer "route_id"
    t.float   "value"
    t.integer "price_customer_id"
  end

  create_table "route", force: true do |t|
    t.text    "prefix"
    t.text    "name"
    t.integer "admin_id"
    t.float   "price_list"
    t.integer "telco_id"
  end

  add_index "route", ["prefix", "telco_id"], name: "index_route_on_prefix_and_telco_id", unique: true, using: :btree

  create_table "sms_queue", force: true do |t|
    t.integer  "contact_id"
    t.integer  "campaign_id"
    t.datetime "process"
    t.datetime "discard"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sms_queue", ["campaign_id"], name: "index_sms_queue_on_campaign_id", using: :btree
  add_index "sms_queue", ["contact_id"], name: "index_sms_queue_on_contact_id", using: :btree

  create_table "tmp_contact_list", force: true do |t|
    t.text     "key"
    t.json     "content"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tmp_contact_list", ["list_id"], name: "index_tmp_contact_list_on_list_id", using: :btree

  create_table "type_customer", force: true do |t|
    t.text    "name"
    t.integer "admin_id"
  end

end
