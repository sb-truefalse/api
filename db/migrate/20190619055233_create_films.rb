class CreateFilms < ActiveRecord::Migration[5.2]
  def change
    create_table :films do |t|
      t.string :local
      t.string :title
      t.date :date
      t.integer :rating
      t.text :description
      t.string :avatar

      t.timestamps
    end
    create_translation_table!
  end

  def create_translation_table!
    reversible do |dir|
      dir.up do
        Film.create_translation_table!({
          title: :string
        }, {
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down { Post.drop_translation_table! migrate_data: true }
    end
  end
end
