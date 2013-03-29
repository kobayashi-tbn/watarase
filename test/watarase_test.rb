require 'test_helper'

class WataraseTest < ActiveSupport::TestCase

  setup do
    setup_app_dir

    @user = User.new
    @user_image_holder = UserImageHolder.new
  end

  test "truth" do
    assert_kind_of Module, Watarase
  end

  test "user_has_user_image_holder" do
    assert_respond_to(@user, :user_image_holder)
  end

  test "user_has_remove_image" do
    assert_respond_to(@user, :remove_image)
  end

  test "user_image_holder_has_uploaded_image=" do
    assert_respond_to(@user_image_holder, :uploaded_image=)
  end

end
