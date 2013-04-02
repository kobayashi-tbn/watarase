$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "watarase/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "watarase"
  s.version     = Watarase::VERSION
  s.authors     = ["kobayashi-tbn"]
  s.email       = ["kobayashi.tbn@gmail.com"]
  s.homepage    = "https://github.com/kobayashi-tbn/watarase"
  s.summary     = "Image uploader for icon"
  s.description = "UploaderGenerator and Plugins"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0.beta1"
  s.add_dependency "rmagick"
  s.add_dependency "actionpack-action_caching"

  s.add_development_dependency "pg"
end
