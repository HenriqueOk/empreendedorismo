class CreateChampionships < ActiveRecord::Migration[5.1]
  def change
    create_table :championships do |t|
      t.string :name
      t.timestamps
    end
  end
end
