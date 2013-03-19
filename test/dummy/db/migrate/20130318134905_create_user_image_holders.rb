class CreateUserImageHolders < ActiveRecord::Migration
  def change
    create_table :user_image_holders do |t|
      t.string :user_username
      t.string :filename
      t.string :content_type
      t.binary :image_data
      t.binary :image_thumb

      t.timestamps
    end
  end
end
