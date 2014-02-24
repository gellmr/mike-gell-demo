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

ActiveRecord::Schema.define(version: 20140224071706) do

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
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "imageUrl"
    t.decimal  "unitPrice",        precision: 7, scale: 2
    t.decimal  "costFromSupplier", precision: 7, scale: 2
    t.integer  "quantityInStock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["name", "description", "imageUrl"], name: "index_products_on_name_and_description_and_imageUrl", using: :btree

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
    t.string   "shipping_address_line_1"
    t.string   "shipping_address_line_2"
    t.string   "shipping_address_city"
    t.string   "shipping_address_state"
    t.string   "shipping_address_post_code"
    t.string   "shipping_address_country_or_region"
    t.string   "billing_address_line_1"
    t.string   "billing_address_line_2"
    t.string   "billing_address_city"
    t.string   "billing_address_state"
    t.string   "billing_address_post_code"
    t.string   "billing_address_country_or_region"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
