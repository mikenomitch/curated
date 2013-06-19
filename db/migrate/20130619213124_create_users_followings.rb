class CreateUsersFollowings < ActiveRecord::Migration
 def up
    create_table :users_followings do |t|
      t.references :user
      t.integer :following_id
    end
  end
 
  def down
    drop_table :users_followings
  end
end