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

ActiveRecord::Schema[7.0].define(version: 2024_04_11_113043) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alcohol_genres", force: :cascade do |t|
    t.string "genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alcohols", force: :cascade do |t|
    t.string "name"
    t.bigint "alcohol_genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alcohol_genre_id"], name: "index_alcohols_on_alcohol_genre_id"
  end

  create_table "appetizer_genres", force: :cascade do |t|
    t.string "genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appetizers", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "base_ingredient_id", null: false
    t.bigint "sub_ingredient_id", null: false
    t.bigint "accent_ingredient_id", null: false
    t.bigint "alcohol_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accent_ingredient_id"], name: "index_appetizers_on_accent_ingredient_id"
    t.index ["alcohol_id"], name: "index_appetizers_on_alcohol_id"
    t.index ["base_ingredient_id"], name: "index_appetizers_on_base_ingredient_id"
    t.index ["sub_ingredient_id"], name: "index_appetizers_on_sub_ingredient_id"
    t.index ["user_id"], name: "index_appetizers_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id", "post_id"], name: "index_likes_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.string "alcohol", null: false
    t.string "appetizer", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "alcohol_genre_id"
    t.bigint "appetizer_genre_id"
    t.string "post_image"
    t.index ["alcohol_genre_id"], name: "index_posts_on_alcohol_genre_id"
    t.index ["appetizer_genre_id"], name: "index_posts_on_appetizer_genre_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "avatar"
    t.text "profile"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "alcohols", "alcohol_genres"
  add_foreign_key "appetizers", "alcohols"
  add_foreign_key "appetizers", "ingredients", column: "accent_ingredient_id"
  add_foreign_key "appetizers", "ingredients", column: "base_ingredient_id"
  add_foreign_key "appetizers", "ingredients", column: "sub_ingredient_id"
  add_foreign_key "appetizers", "users"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "posts", "alcohol_genres"
  add_foreign_key "posts", "appetizer_genres"
  add_foreign_key "posts", "users"
end
