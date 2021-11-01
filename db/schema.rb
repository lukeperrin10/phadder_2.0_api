# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_01_091347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "post_code"
    t.string "city"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.bigint "service_provider_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_provider_id"], name: "index_addresses_on_service_provider_id"
  end

  create_table "bids", force: :cascade do |t|
    t.float "amount"
    t.bigint "service_request_id"
    t.bigint "creator_id"
    t.bigint "service_provider_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_bids_on_creator_id"
    t.index ["service_provider_id"], name: "index_bids_on_service_provider_id"
    t.index ["service_request_id"], name: "index_bids_on_service_request_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "service_provider_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_provider_id"], name: "index_categories_on_service_provider_id"
  end

  create_table "categories_service_providers", id: false, force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "service_provider_id", null: false
  end

  create_table "categories_service_requests", id: false, force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "service_request_id", null: false
  end

  create_table "deals", force: :cascade do |t|
    t.bigint "bid_id"
    t.bigint "service_request_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "creator_id"
    t.index ["bid_id"], name: "index_deals_on_bid_id"
    t.index ["creator_id"], name: "index_deals_on_creator_id"
    t.index ["service_request_id"], name: "index_deals_on_service_request_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.integer "origin"
    t.bigint "receiver_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receiver_id"], name: "index_messages_on_receiver_id"
  end

  create_table "service_providers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "service_requests", force: :cascade do |t|
    t.string "title"
    t.text "details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.string "state"
    t.integer "budget"
    t.integer "time_frame"
    t.index ["user_id"], name: "index_service_requests_on_user_id"
  end

  create_table "tracked_service_requests", force: :cascade do |t|
    t.bigint "service_provider_id"
    t.bigint "service_request_id"
    t.bigint "creator_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_tracked_service_requests_on_creator_id"
    t.index ["service_provider_id"], name: "index_tracked_service_requests_on_service_provider_id"
    t.index ["service_request_id"], name: "index_tracked_service_requests_on_service_request_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "role"
    t.bigint "service_provider_id"
    t.string "language_code"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["service_provider_id"], name: "index_users_on_service_provider_id"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "service_providers"
  add_foreign_key "bids", "service_providers"
  add_foreign_key "bids", "service_requests"
  add_foreign_key "bids", "users", column: "creator_id"
  add_foreign_key "categories", "service_providers"
  add_foreign_key "deals", "bids"
  add_foreign_key "deals", "service_requests"
  add_foreign_key "deals", "users", column: "creator_id"
  add_foreign_key "messages", "users", column: "receiver_id"
  add_foreign_key "service_requests", "users"
  add_foreign_key "tracked_service_requests", "service_providers"
  add_foreign_key "tracked_service_requests", "service_requests"
  add_foreign_key "tracked_service_requests", "users", column: "creator_id"
  add_foreign_key "users", "service_providers"
end
