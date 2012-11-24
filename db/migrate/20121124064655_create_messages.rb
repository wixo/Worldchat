class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :chatroom_id
      t.integer :user_id

      t.timestamps
    end
  end
end
