class CreateFilmGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :film_genres do |t|
      t.references :film
      t.references :genre

      t.timestamps
    end
  end
end
