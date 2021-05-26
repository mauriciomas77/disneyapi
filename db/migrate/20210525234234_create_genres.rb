class CreateGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :genres do |t|
      t.string :genre_name
      t.string :image_url

      t.timestamps
    end
  end
end
