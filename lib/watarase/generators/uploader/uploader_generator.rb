module Watarase
  module Generators
    class UploaderGenerator < Base
      def create_image_holder
        image_handler = file_name.camelcase.constantize
        fk = image_handler.primary_key
        fk_type = ((image_handler.respond_to? :columns) ? image_handler.columns.select{|column| column.name == fk}.first.type : :integer)
        model_name = "#{file_name}_#{Watarase.suffix}"

        str_code = <<-"CODE"

  image_holdable

  belongs_to :#{file_name}, primary_key: :#{fk}, foreign_key: :#{file_name}_#{fk}

        CODE

        generate "model", "#{model_name} #{file_name}_#{fk}:#{fk_type} filename:string content_type:string image_data:binary image_thumb:binary"
        inject_into_class "app/models/#{model_name}.rb", model_name.camelcase.constantize do
          str_code
        end
      end
    end
  end
end
