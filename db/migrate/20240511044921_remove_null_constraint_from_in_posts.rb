class RemoveNullConstraintFromInPosts < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :body, :text, null: true
  end
end
