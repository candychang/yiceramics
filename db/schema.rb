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

ActiveRecord::Schema.define(version: 20170203225643) do

  create_table "addresses", force: :cascade do |t|
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.string   "category",         limit: 64
    t.string   "full_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state_code"
    t.string   "country_code"
    t.string   "postal_code"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  add_index "addresses", ["addressable_id"], name: "index_addresses_on_addressable_id"
  add_index "addresses", ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"

  create_table "admins", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  create_table "cart_items", force: :cascade do |t|
    t.decimal  "unit_price",  precision: 12, scale: 3
    t.integer  "quantity"
    t.decimal  "total_price", precision: 12, scale: 3
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "work_id"
    t.integer  "cart_id"
  end

  add_index "cart_items", ["cart_id"], name: "index_cart_items_on_cart_id"
  add_index "cart_items", ["work_id"], name: "index_cart_items_on_work_id"

  create_table "cart_sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order_id"
  end

  add_index "carts", ["order_id"], name: "index_carts_on_order_id"

  create_table "orders", force: :cascade do |t|
    t.string   "braintree_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
    t.string   "email"
    t.decimal  "amount"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "works", force: :cascade do |t|
    t.string   "name"
    t.text     "details"
    t.string   "size"
    t.string   "clay_type"
    t.string   "fire_type"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "image"
    t.integer  "quantity",                                default: 1
    t.decimal  "price",          precision: 12, scale: 3
    t.integer  "cone"
    t.boolean  "shop_active"
    t.boolean  "gallery_active"
  end

end
