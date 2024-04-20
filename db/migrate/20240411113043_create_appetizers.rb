class CreateAppetizers < ActiveRecord::Migration[7.0]
  def change
    create_table :appetizers do |t|
      t.string :name
      t.text :description
      t.references :base_ingredient, null: false, foreign_key: { to_table: :ingredients }, type: :bigint
      t.references :sub_ingredient, null: false, foreign_key: { to_table: :ingredients }, type: :bigint
      t.references :accent_ingredient, null: false, foreign_key: { to_table: :ingredients }, type: :bigint
      t.references :alcohol, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
