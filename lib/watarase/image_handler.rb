require 'active_record/base'

module Watarase
  module ImageHandler
    def self.included(model)
      model.extend Watarase::ImageHandler::Macro
    end
  end
end

module Watarase
  module ImageHandler
    module Macro
      def acts_as_image_handler
        image_holder = (self.name.underscore << '_' << Watarase.suffix).to_sym
        self.send(:include, Watarase::ImageHandler::Associate)
        self.send(:has_one, image_holder, primary_key: self.primary_key, foreign_key: "#{self.name.underscore}_#{self.primary_key}", autosave: true, dependent: :destroy)
        self.send(:attr_accessor, :remove_image)
        self.send(:before_save, :update_image_holder)
      end
    end

    module Associate
      def update_image_holder
        puts "**** update image holder **** #{Thread.current[:image_params]} ****"
        image_holder = (self.class.name.underscore << '_' << Watarase.suffix)
        return if (!self.send(image_holder.to_sym) and (!Thread.current[:image_params] or !Thread.current[:image_params][:image_file]))

        self.send((image_holder + '=').to_sym, UserImageHolder.new) unless self.send(image_holder.to_sym)
        self.send(image_holder.to_sym).send(:uploaded_image=, (Thread.current[:image_params] || {}))
      end
    end
  end
end

ActiveRecord::Base.send :include, Watarase::ImageHandler unless ActiveRecord::Base.include? Watarase::ImageHandler

