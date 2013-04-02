module Watarase
  module Controller
    def self.included(controller)
      controller.extend Watarase::ImageLoader
    end
  end

  module ImageLoader
    def image_loadable(_image_handler, options = {})
      require 'action_controller/action_caching'

      ih = _image_handler.to_s.camelize.constantize
      self.class_variable_set(:@@image_handler, ih)
      self.send(:include, Watarase::InstanceMethods)
      self.send(:caches_action, :load_image) if options[:caches]
      self.send(:after_action, :expire_caches, options[:expire_actions]) if options[:expire_actions]
      self.send(:helper_method, :image_thumb_path)
      self.send(:helper_method, :image_data_path)
    end
  end

  module InstanceMethods
    def load_image
      image = image_holder.find(params[:id])
      column_name = :"#{(params[:image_column] || 'image_data')}"
      send_data image.send(column_name), type: image.content_type, disposition: 'inline'
    end

    def expire_caches
      expire_action action: :load_image
    end

    def image_params
      params.require(image_handler.name.underscore.to_sym).permit(:image_file, :remove_image)
    end

    def image_handler
      self.class.class_variable_get(:@@image_handler)
    end

    def image_holder
      "#{image_handler.name.underscore}_#{Watarase.suffix}".camelize.constantize
    end

    def image_thumb_path(model)
      url_for(controller: image_handler.name.downcase!.pluralize, action: 'load_image', id: model.send(:"#{image_holder.name.underscore}").id, image_column: :image_thumb)
    end

    def image_data_path(model)
      url_for(controller: image_handler.name.downcase!.pluralize, action: 'load_image', id: model.send(:"#{image_holder.name.underscore}").id, image_column: :image_data)
    end

    # Call before create, update
    def set_image_holder(_image_handler)
      _image_handler.send(:"#{image_holder.name.underscore}=", image_holder.new) unless _image_handler.send(:"#{image_holder.name.underscore}")
      _image_handler.send(:"#{image_holder.name.underscore}").uploaded_image = image_params
    end
  end
end

ActionController::Base.send :include, Watarase::Controller unless ActionController::Base.include? Watarase::Controller
