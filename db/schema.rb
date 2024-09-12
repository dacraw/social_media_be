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

ActiveRecord::Schema[7.1].define(version: 2024_09_12_121111) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "post_id"
    t.text "message", null: false
    t.datetime "commented_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "github_events", force: :cascade do |t|
    t.string "repo_name"
    t.string "branch"
    t.string "event_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "github_id"
    t.bigint "user_id", null: false
    t.datetime "date"
    t.index ["github_id"], name: "index_github_events_on_github_id"
    t.index ["user_id"], name: "index_github_events_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.bigint "user_id"
    t.datetime "posted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "timeline_items", force: :cascade do |t|
    t.string "timelineable_type"
    t.bigint "timelineable_id"
    t.string "event", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "message"
    t.index ["timelineable_type", "timelineable_id"], name: "index_timeline_items_on_timelineable"
    t.index ["user_id"], name: "index_timeline_items_on_user_id"
  end

  create_table "user_ratings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "rater_id"
    t.integer "rating"
    t.datetime "rated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rater_id"], name: "index_user_ratings_on_rater_id"
    t.index ["user_id"], name: "index_user_ratings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "github_username"
    t.datetime "registered_at", null: false
    t.string "jti"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
  end

  add_foreign_key "github_events", "users"
  add_foreign_key "timeline_items", "users"
  add_foreign_key "user_ratings", "users", column: "rater_id"
end
