#require 'RMagick'
require 'rmagick'

module Watarase
  module ImageHolder
    def self.included(model)
      model.extend Watarase::ImageHolder::Macro
    end
  end
end

module Watarase
  module ImageHolder
    module Macro
      def acts_as_image_holder
        self.send(:include, Watarase::ImageHolder::ExtensionWhitelist)
        self.send(:include, Watarase::ImageHolder::Store)
        self.send(:before_save, :prepare_image)
      end
    end

    module Store
      def uploaded_image= (image_params)
        puts "**** uploaded_image ****"
        if image_params[:remove_image] && image_params[:remove_image] == "1"
          self.destroy
        elsif image_params[:image_file] && !image_params[:image_file].blank?
          self.filename = image_params[:image_file].original_filename
          @image_filename = self.filename
          self.content_type = image_params[:image_file].content_type
          @data = image_params[:image_file].tempfile.read
        elsif self.new_record?
          self.destroy
        end
      end

      def prepare_image
        puts "**** prepare_image ****"
        return unless @data
        self.image_data = Magick::Image.from_blob(@data).first.resize_to_fit(100, 100).to_blob
        self.image_thumb = Magick::Image.from_blob(@data).first.thumbnail(35, 35).to_blob
      end
    end
  end
end

ActiveRecord::Base.send :include, Watarase::ImageHolder unless ActiveRecord::Base.include? Watarase::ImageHolder
