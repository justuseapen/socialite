class CreateTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :twitter_accounts do |t|
      t.integer :list_id
      t.string :handle, null: false

      t.timestamps null: false
    end
  end
end
