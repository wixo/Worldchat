class User < ActiveRecord::Base
  attr_accessible :foursquare_id, :name, :venue_id
end
