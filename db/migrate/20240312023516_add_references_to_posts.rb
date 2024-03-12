class AddReferencesToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :alcohol_genre, foreign_key: true
    add_reference :posts, :appetizer_genre, foreign_key: true
  end
end
