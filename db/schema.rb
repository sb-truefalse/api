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

ActiveRecord::Schema.define(version: 2019_06_20_073745) do

  create_table "film_countries", force: :cascade do |t|
    t.integer "film_id"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["film_id", "country"], name: "index_film_countries_on_film_id_and_country", unique: true
    t.index ["film_id"], name: "index_film_countries_on_film_id"
  end

  create_table "film_genres", force: :cascade do |t|
    t.integer "film_id"
    t.integer "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["film_id", "genre_id"], name: "index_film_genres_on_film_id_and_genre_id", unique: true
    t.index ["film_id"], name: "index_film_genres_on_film_id"
    t.index ["genre_id"], name: "index_film_genres_on_genre_id"
  end

  create_table "film_translations", force: :cascade do |t|
    t.integer "film_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["film_id"], name: "index_film_translations_on_film_id"
    t.index ["locale"], name: "index_film_translations_on_locale"
  end

  create_table "films", force: :cascade do |t|
    t.string "local"
    t.date "date"
    t.integer "rating"
    t.text "description"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
