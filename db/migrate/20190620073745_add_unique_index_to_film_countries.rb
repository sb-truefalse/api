class AddUniqueIndexToFilmCountries < ActiveRecord::Migration[5.2]
  def change
    add_index :film_countries, [:film_id, :country], unique: true
  end
end
