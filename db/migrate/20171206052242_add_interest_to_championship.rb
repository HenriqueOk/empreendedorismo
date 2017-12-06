class AddInterestToChampionship < ActiveRecord::Migration[5.0]
  def change
    add_column :interests, :championship_id, :integer
  end
end
