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

ActiveRecord::Schema.define(version: 20141010021131) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ordered_products", force: true do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.integer "qty"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.datetime "order_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "order_status"
    t.integer  "shipping_address"
    t.integer  "billing_address"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image_url"
    t.decimal  "unit_price",         precision: 7, scale: 2
    t.decimal  "cost_from_supplier", precision: 7, scale: 2
    t.integer  "quantity_in_stock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["name", "description", "image_url"], name: "index_products_on_name_and_description_and_image_url", using: :btree

  create_table "user_addresses", force: true do |t|
    t.integer "user_id"
    t.string  "line_1"
    t.string  "line_2"
    t.string  "city"
    t.string  "state"
    t.string  "postcode"
    t.string  "country_or_region"
    t.boolean "deleted",           default: false
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "mobile_phone"
    t.boolean  "account_locked"
    t.datetime "token_created_at"
    t.string   "password_reset_token"
    t.integer  "shipping_address"
    t.integer  "billing_address"
    t.string   "usertype",             default: "customer"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
