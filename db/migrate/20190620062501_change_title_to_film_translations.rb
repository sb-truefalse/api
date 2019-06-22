class ChangeTitleToFilmTranslations < ActiveRecord::Migration[5.2]
  def change
		change_column_null :film_translations, :title, true
  end
end
