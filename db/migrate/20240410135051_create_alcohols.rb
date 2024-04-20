class CreateAlcohols < ActiveRecord::Migration[7.0]
  def change
    create_table :alcohols do |t|
      t.string :name
      t.references :alcohol_genre, foreign_key: true

      t.timestamps
    end
  end
end
