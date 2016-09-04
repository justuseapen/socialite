class CreateBufferProfiles < ActiveRecord::Migration
  def change
    create_table :buffer_profiles do |t|
      t.string :formatted_username
      t.string :buffer_id
      t.string :avatar_url

      t.timestamps null: false
    end
  end
end
