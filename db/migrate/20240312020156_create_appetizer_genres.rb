class CreateAppetizerGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :appetizer_genres do |t|
      t.string :genre

      t.timestamps
    end
  end
end
