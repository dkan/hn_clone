class CreateFlaggedArticles < ActiveRecord::Migration
  def change
    create_table :flagged_articles do |t|
      t.integer :article_id

      t.timestamps
    end
  end
end
