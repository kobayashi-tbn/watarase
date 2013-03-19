module Watarase
  module Generators
    class UploaderGenerator < Base
      #def create_model_file
      def create_image_holder

        image_handler = file_name.camelcase.constantize
        fk = image_handler.primary_key
        fk_type = ((image_handler.respond_to? :columns) ? image_handler.columns.select{|column| column.name == fk}.first.type : :integer)
        model_name = "#{file_name}_#{Watarase.suffix}"

        # RMagick
        str_include = "  include Magick unless self.include? Magick\n"

        # Associations
        str_belongs_to = "  belongs_to :#{file_name}, primary_key: :#{fk}, foreign_key: :#{file_name}_#{fk}\n"

        # Instance Methods
        str_methods = <<-CODE

  def uploaded_image= (image_params)
    if image_params[:remove_image] && image_params[:remove_image] == "1"
      self.destroy
    elsif image_params[:image_file] && !image_params[:image_file].blank?
      self.filename = image_params[:image_file].original_filename
      self.content_type = image_params[:image_file].content_type
      data = image_params[:image_file].tempfile.read
      self.image_data = Image.from_blob(data).first.resize_to_fit(100, 100).to_blob
      self.image_thumb = Image.from_blob(data).first.thumbnail(35, 35).to_blob
    elsif self.new_record?
      self.destroy
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
        CODE

        generate "model", "#{model_name} #{file_name}_#{fk}:#{fk_type} filename:string content_type:string image_data:binary image_thumb:binary"
        inject_into_class "app/models/#{model_name}.rb", model_name.camelcase.constantize do
          str_include << str_belongs_to << str_methods
        end
      end
    end
  end
end
