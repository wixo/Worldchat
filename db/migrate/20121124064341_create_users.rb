class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :venue_id
      t.integer :foursquare_id

      t.timestamps
    end
  end
end
