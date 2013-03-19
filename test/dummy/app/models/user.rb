class User < ActiveRecord::Base
  self.primary_key = :username
  acts_as_image_handler
end
