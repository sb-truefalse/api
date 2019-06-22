class AddUniqueIndexToFilmGenres < ActiveRecord::Migration[5.2]
  def change
    add_index :film_genres, [:film_id, :genre_id], unique: true
  end
end
