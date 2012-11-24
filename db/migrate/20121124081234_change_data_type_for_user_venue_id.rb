class ChangeDataTypeForUserVenueId < ActiveRecord::Migration
  def up
  	change_table :users do |t|
  		t.change :venue_id, :string
  	end
  end

  def down
  	change_table :users do |t|
  		t.change :venue_id, :integer
  	end
  end
end
