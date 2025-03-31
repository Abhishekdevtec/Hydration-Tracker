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

ActiveRecord::Schema[8.0].define(version: 2025_03_30_193324) do
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
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "beverage_additions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_custom", default: false
  end

  create_table "beverage_entries", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "beverage_type_id", null: false
    t.integer "beverage_subtype_id", null: false
    t.datetime "consumed_at"
    t.decimal "quantity"
    t.string "unit"
    t.string "temperature"
    t.string "custom_type"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beverage_subtype_id"], name: "index_beverage_entries_on_beverage_subtype_id"
    t.index ["beverage_type_id"], name: "index_beverage_entries_on_beverage_type_id"
    t.index ["user_id"], name: "index_beverage_entries_on_user_id"
  end

  create_table "beverage_entry_additions", force: :cascade do |t|
    t.integer "beverage_entry_id", null: false
    t.integer "beverage_addition_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beverage_addition_id"], name: "index_beverage_entry_additions_on_beverage_addition_id"
    t.index ["beverage_entry_id"], name: "index_beverage_entry_additions_on_beverage_entry_id"
  end

  create_table "beverage_entry_symptoms", force: :cascade do |t|
    t.integer "beverage_entry_id", null: false
    t.integer "symptom_id", null: false
    t.string "severity"
    t.string "timing"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beverage_entry_id"], name: "index_beverage_entry_symptoms_on_beverage_entry_id"
    t.index ["symptom_id"], name: "index_beverage_entry_symptoms_on_symptom_id"
  end

  create_table "beverage_subtypes", force: :cascade do |t|
    t.string "name"
    t.integer "beverage_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beverage_type_id"], name: "index_beverage_subtypes_on_beverage_type_id"
  end

  create_table "beverage_types", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_custom", default: false
  end

  create_table "symptoms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_custom", default: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "beverage_entries", "beverage_subtypes"
  add_foreign_key "beverage_entries", "beverage_types"
  add_foreign_key "beverage_entries", "users"
  add_foreign_key "beverage_entry_additions", "beverage_additions"
  add_foreign_key "beverage_entry_additions", "beverage_entries"
  add_foreign_key "beverage_entry_symptoms", "beverage_entries"
  add_foreign_key "beverage_entry_symptoms", "symptoms"
  add_foreign_key "beverage_subtypes", "beverage_types"
end
