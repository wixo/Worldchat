class Chatroom < ActiveRecord::Base
  attr_accessible :is_available, :name, :venue_id

  has_many :users
  has_many :messages
end
