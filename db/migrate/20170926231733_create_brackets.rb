class CreateBrackets < ActiveRecord::Migration[5.1]
  def change
    create_table "brackets", force: :cascade do |t|
      t.integer  "championship_id"
      t.integer  "player_1_id"
      t.integer  "player_2_id"
      t.integer  "winner_id"
      t.integer  "parent_id"
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
      t.index ["championship_id"], name: "index_brackets_on_championship_id", using: :btree
      t.index ["parent_id"], name: "index_brackets_on_parent_id", using: :btree
      t.index ["player_1_id"], name: "index_brackets_on_player_1_id", using: :btree
      t.index ["player_2_id"], name: "index_brackets_on_player_2_id", using: :btree
      t.index ["winner_id"], name: "index_brackets_on_winner_id", using: :btree
    end
  end
end
