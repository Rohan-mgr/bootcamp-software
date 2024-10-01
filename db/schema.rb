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

ActiveRecord::Schema[7.2].define(version: 2024_10_01_171514) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: :cascade do |t|
    t.string "asset_id"
    t.string "asset_status"
    t.string "asset_category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", null: false
    t.bigint "user_id", null: false
    t.index ["asset_id"], name: "index_assets_on_asset_id", unique: true
    t.index ["organization_id"], name: "index_assets_on_organization_id"
    t.index ["user_id"], name: "index_assets_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "category_class"
    t.bigint "user_id", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_categories_on_organization_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "customer_branches", force: :cascade do |t|
    t.string "name"
    t.text "location"
    t.bigint "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["customer_id"], name: "index_customer_branches_on_customer_id"
    t.index ["deleted_at"], name: "index_customer_branches_on_deleted_at"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_no"
    t.string "email"
    t.integer "zipcode"
    t.string "address"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_customers_on_deleted_at"
  end

  create_table "delivery_orders", force: :cascade do |t|
    t.datetime "planned_at", null: false
    t.datetime "completed_at"
    t.bigint "customer_branch_id", null: false
    t.bigint "order_group_id", null: false
    t.bigint "asset_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "driver_id"
    t.datetime "deleted_at"
    t.index ["asset_id"], name: "index_delivery_orders_on_asset_id"
    t.index ["customer_branch_id"], name: "index_delivery_orders_on_customer_branch_id"
    t.index ["deleted_at"], name: "index_delivery_orders_on_deleted_at"
    t.index ["driver_id"], name: "index_delivery_orders_on_driver_id"
    t.index ["order_group_id"], name: "index_delivery_orders_on_order_group_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "status"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["organization_id"], name: "index_drivers_on_organization_id"
    t.index ["user_id"], name: "index_drivers_on_user_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.string "name", null: false
    t.float "quantity", null: false
    t.string "units", null: false
    t.bigint "delivery_order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_line_items_on_deleted_at"
    t.index ["delivery_order_id"], name: "index_line_items_on_delivery_order_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_memberships_on_customer_id"
    t.index ["organization_id"], name: "index_memberships_on_organization_id"
  end

  create_table "order_groups", force: :cascade do |t|
    t.string "status", default: "pending", null: false
    t.datetime "started_at"
    t.datetime "completed_at"
    t.bigint "customer_id"
    t.bigint "organization_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "recurring"
    t.integer "parent_order_id"
    t.boolean "is_self_updated", default: false
    t.datetime "cancelled_at"
    t.datetime "deleted_at"
    t.index ["customer_id"], name: "index_order_groups_on_customer_id"
    t.index ["deleted_at"], name: "index_order_groups_on_deleted_at"
    t.index ["organization_id"], name: "index_order_groups_on_organization_id"
    t.index ["user_id"], name: "index_order_groups_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "product_category"
    t.string "product_status"
    t.string "product_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_products_on_organization_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "roles", default: "member", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti"
    t.bigint "organization_id", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti"
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "assets", "organizations"
  add_foreign_key "assets", "users"
  add_foreign_key "categories", "organizations"
  add_foreign_key "categories", "users"
  add_foreign_key "customer_branches", "customers"
  add_foreign_key "delivery_orders", "assets"
  add_foreign_key "delivery_orders", "customer_branches"
  add_foreign_key "delivery_orders", "drivers"
  add_foreign_key "delivery_orders", "order_groups"
  add_foreign_key "drivers", "organizations"
  add_foreign_key "drivers", "users"
  add_foreign_key "line_items", "delivery_orders"
  add_foreign_key "memberships", "customers"
  add_foreign_key "memberships", "organizations"
  add_foreign_key "order_groups", "customers", on_delete: :nullify
  add_foreign_key "order_groups", "organizations"
  add_foreign_key "order_groups", "users"
  add_foreign_key "products", "organizations"
  add_foreign_key "products", "users"
  add_foreign_key "users", "organizations"
end
