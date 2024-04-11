class CreateAlcoholAppetizers < ActiveRecord::Migration[7.0]
  def change
    create_table :alcohol_appetizers do |t|
      t.references :alcohol, null: false, foreign_key: true
      t.references :appetizer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
