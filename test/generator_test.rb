require 'test_helper'
require 'rails/generators'
require 'watarase/generators/uploader/uploader_generator'
require 'active_support'
require 'active_support/core_ext'
#require 'rails/generators/active_record/model/model_generator'
require 'rails/generators/rails/model/model_generator'

class GeneratorTest < Rails::Generators::TestCase
  tests Watarase::Generators::UploaderGenerator
  destination File.expand_path("dummy", File.dirname(__FILE__))
  setup :prepare_destination

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    setup_app_dir
  end

  test 'Image holder PostImageHolder is created' do
    assert_file "app/models/post.rb"
    run_generator %w(post)

    assert_file "app/models/post_image_holder.rb"
    assert_migration "db/migrate/create_post_image_holders.rb"
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    #self.class.setup :prepare_destination
  end

  ## Fake test
  #def test_fail
  #
  #  # To change this template use File | Settings | File Templates.
  #  fail('Not implemented')
  #end
end

