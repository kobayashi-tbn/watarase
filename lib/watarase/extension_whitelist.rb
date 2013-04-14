module Watarase
  module ImageHolder
    module ExtensionWhitelist

      def self.included(model)
        model.send(:before_save, :check_extension)
      end

      def check_extension
        puts "**** check_extension ****"
        if filename && extension_white_list && !extension_white_list.include?(File.extname(filename).sub(/\./, ''))
          raise StandardError, "Unsupported file " + filename
        end
      end

      def extension_white_list
        %w(jpg jpeg gif png)
      end
    end
  end
end