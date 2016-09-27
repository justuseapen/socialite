class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name, null: false
      t.integer :user_id
      t.integer :buffer_profile_id

      t.timestamps null: false
    end
  end
end
