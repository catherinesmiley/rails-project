class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :song_id
      t.integer :playlist_id

      t.timestamps
    end
  end
end
