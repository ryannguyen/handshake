class AddFieldsToChirp < ActiveRecord::Migration[6.1]
  def change
    add_column :chirps, :votes, :integer
  end
end
