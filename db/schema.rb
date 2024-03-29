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

ActiveRecord::Schema[7.0].define(version: 2024_03_28_235248) do
  create_table "cryptos", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "monthly_return"
  end

  create_table "investments", force: :cascade do |t|
    t.decimal "amount"
    t.integer "user_id", null: false
    t.integer "crypto_id", null: false
    t.integer "period"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "status"
    t.integer "wallet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "crypto_taken_value"
    t.index ["crypto_id"], name: "index_investments_on_crypto_id"
    t.index ["user_id"], name: "index_investments_on_user_id"
    t.index ["wallet_id"], name: "index_investments_on_wallet_id"
  end

  create_table "profits", force: :cascade do |t|
    t.string "status"
    t.decimal "amount"
    t.date "paid_date"
    t.integer "investment_id", null: false
    t.integer "wallet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["investment_id"], name: "index_profits_on_investment_id"
    t.index ["wallet_id"], name: "index_profits_on_wallet_id"
  end

  create_table "releases", force: :cascade do |t|
    t.decimal "profit_amount"
    t.decimal "amount"
    t.date "received_at"
    t.integer "wallet_id", null: false
    t.integer "investment_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["investment_id"], name: "index_releases_on_investment_id"
    t.index ["user_id"], name: "index_releases_on_user_id"
    t.index ["wallet_id"], name: "index_releases_on_wallet_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "wallet_id", null: false
    t.integer "user_id", null: false
    t.integer "investment_id"
    t.decimal "amount"
    t.string "transaction_type"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["investment_id"], name: "index_transactions_on_investment_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
    t.index ["wallet_id"], name: "index_transactions_on_wallet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.string "user_code"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["parent_id"], name: "index_users_on_parent_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "wallet_types", force: :cascade do |t|
    t.string "name_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wallets", force: :cascade do |t|
    t.string "name"
    t.decimal "amount", default: "0.0"
    t.integer "user_id", null: false
    t.integer "wallet_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
    t.index ["wallet_type_id"], name: "index_wallets_on_wallet_type_id"
  end

  add_foreign_key "investments", "wallets"
  add_foreign_key "profits", "investments"
  add_foreign_key "profits", "wallets"
  add_foreign_key "releases", "investments"
  add_foreign_key "releases", "users"
  add_foreign_key "releases", "wallets"
  add_foreign_key "transactions", "investments"
  add_foreign_key "transactions", "users"
  add_foreign_key "transactions", "wallets"
  add_foreign_key "wallets", "users"
  add_foreign_key "wallets", "wallet_types"
end
