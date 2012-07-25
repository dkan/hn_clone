class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.string :body
      t.integer :article_id
      t.integer :parent_comment_id

      t.timestamps
    end
  end
end
