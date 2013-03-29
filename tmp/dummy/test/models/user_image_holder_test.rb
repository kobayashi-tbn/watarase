require 'test_helper'

class UserImageHolderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user_image_holder = UserImageHolder.first
  end

  test "image holder has image handler" do
    assert_respond_to(@user_image_holder, :user)
  end
end
