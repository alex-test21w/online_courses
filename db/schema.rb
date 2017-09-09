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

ActiveRecord::Schema.define(version: 20170908091543) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "outcast", default: false
    t.boolean "subscription", default: true
    t.index ["user_id", "course_id"], name: "index_course_users_on_user_id_and_course_id", unique: true
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.integer "user_id"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "homeworks", force: :cascade do |t|
    t.text "description", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lesson_id"
    t.index ["lesson_id"], name: "index_homeworks_on_lesson_id"
    t.index ["user_id"], name: "index_homeworks_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title", null: false
    t.integer "position", null: false
    t.text "descriprion"
    t.string "picture"
    t.string "synopsis"
    t.text "homework"
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "social_profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "uid"
    t.string "service_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "service_name"], name: "index_social_profiles_on_user_id_and_service_name", unique: true
    t.index ["user_id"], name: "index_social_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
