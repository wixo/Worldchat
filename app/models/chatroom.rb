class Chatroom < ActiveRecord::Base
  attr_accessible :is_available, :name, :venue_id
end
