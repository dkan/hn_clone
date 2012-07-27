class CreateBannedUsers < ActiveRecord::Migration
  def change
    create_table :banned_users do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
