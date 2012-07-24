class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :voteable_id
      t.string  :voteable_type
      t.integer :value

      t.timestamps
    end
  end
end
