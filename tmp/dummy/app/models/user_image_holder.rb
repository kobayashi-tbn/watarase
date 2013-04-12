class UserImageHolder < ActiveRecord::Base

  image_holdable

  belongs_to :user, primary_key: :username, foreign_key: :user_username

end
