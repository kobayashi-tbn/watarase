require 'active_record/base'

module Watarase
  module Model
    def self.included(model)
      model.extend Watarase::ActsAsImageHandler
    end
  end

  module ActsAsImageHandler
    def acts_as_image_handler
      image_holder = (self.name.underscore << '_' << Watarase.suffix).to_sym
      self.send(:has_one, image_holder, primary_key: self.primary_key, foreign_key: "#{self.name.underscore}_#{self.primary_key}", autosave: true)
      self.send(:attr_accessor, :remove_image)
    end
  end
end

ActiveRecord::Base.send :include, Watarase::Model unless ActiveRecord::Base.include? Watarase::Model

