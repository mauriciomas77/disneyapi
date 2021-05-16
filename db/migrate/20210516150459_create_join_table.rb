class CreateJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :age
      t.float :weigth
      t.text :history
      t.string :image_url
    end

    create_table :movies do |t|
      t.string :title
      t.integer :released_year
      t.integer :rating
      t.string :image_url
      t.references :genre, null: false, foreign_key: true
    end

    create_table :characters_movies, id: false do |t|
      t.belongs_to :character
      t.belongs_to :movie
    end
  end
end
