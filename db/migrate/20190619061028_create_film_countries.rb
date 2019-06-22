class CreateFilmCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :film_countries do |t|
      t.references :film, foreign_key: true
      t.string :country, foreign_key: true

      t.timestamps
    end
  end
end
