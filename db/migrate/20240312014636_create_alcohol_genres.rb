class CreateAlcoholGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :alcohol_genres do |t|
      t.string :genre

      t.timestamps
    end
  end
end
