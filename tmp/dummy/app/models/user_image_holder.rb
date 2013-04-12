class UserImageHolder < ActiveRecord::Base
  include Watarase::ExtensionWhitelist unless self.include? Watarase::ExtensionWhitelist
  include Watarase::ImageHolder unless self.include? Watarase::ImageHolder

  belongs_to :user, primary_key: :username, foreign_key: :user_username
  attr_accessor :image_filename

  #def uploaded_image= (image_params)
  #  if image_params[:remove_image] && image_params[:remove_image] == "1"
  #    self.destroy
  #  elsif image_params[:image_file] && !image_params[:image_file].blank?
  #    self.filename = image_params[:image_file].original_filename
  #    self.content_type = image_params[:image_file].content_type
  #    data = image_params[:image_file].tempfile.read
  #    self.image_data = Image.from_blob(data).first.resize_to_fit(100, 100).to_blob
  #    self.image_thumb = Image.from_blob(data).first.thumbnail(35, 35).to_blob
  #  elsif self.new_record?
  #    self.destroy
  #  end
  #end
  #
  #def extension_white_list
  #  %w(jpg jpeg gif png)
  #end
end
