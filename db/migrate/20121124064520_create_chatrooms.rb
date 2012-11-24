class CreateChatrooms < ActiveRecord::Migration
  def change
    create_table :chatrooms do |t|
      t.integer :venue_id
      t.string :name
      t.boolean :is_available

      t.timestamps
    end
  end
end
