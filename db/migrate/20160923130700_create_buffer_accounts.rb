class CreateBufferAccounts < ActiveRecord::Migration
  def change
    create_table :buffer_accounts do |t|
    	t.integer :user_id
    	t.string :access_token
    	t.string :uid

      t.timestamps null: false
    end
  end
end
