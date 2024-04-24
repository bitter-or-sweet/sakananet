class AddColumnsToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :address, :text
    add_column :posts, :latitude, :float
    add_column :posts, :longitude, :float
  end
end
