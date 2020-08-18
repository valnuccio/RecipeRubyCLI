# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_18_185906) do

  create_table "ingredient_recipes", force: :cascade do |t|
    t.integer "ingredient_id"
    t.integer "recipe_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title"
    t.integer "minutes_to_make"
    t.integer "servings"
    t.string "directions"
    t.string "photo_url"
    t.string "nutrition_facts"
    t.float "price"
    t.integer "spoonacular_id"
  end

  create_table "user_ingredients", force: :cascade do |t|
    t.integer "user_id"
    t.integer "ingredient_id"
  end

  create_table "user_recipes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "recipe_id"
    t.integer "times_made"
    t.string "review"
    t.integer "star_rating"
    t.datetime "last_time_made"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "name"
    t.string "location"
    t.boolean "logged_in"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
