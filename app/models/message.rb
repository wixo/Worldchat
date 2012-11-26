class Message < ActiveRecord::Base
  attr_accessible :chatroom_id, :content, :user_id

  belongs_to :user
end
