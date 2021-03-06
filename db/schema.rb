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

ActiveRecord::Schema.define(version: 20170926231733) do

  create_table "brackets", force: :cascade do |t|
    t.integer "championship_id"
    t.integer "player_1_id"
    t.integer "player_2_id"
    t.integer "winner_id"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["championship_id"], name: "index_brackets_on_championship_id"
    t.index ["parent_id"], name: "index_brackets_on_parent_id"
    t.index ["player_1_id"], name: "index_brackets_on_player_1_id"
    t.index ["player_2_id"], name: "index_brackets_on_player_2_id"
    t.index ["winner_id"], name: "index_brackets_on_winner_id"
  end

  create_table "championships", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer "championship_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["championship_id"], name: "index_games_on_championship_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "championship_id"
    t.index ["championship_id"], name: "index_players_on_championship_id"
  end

end
