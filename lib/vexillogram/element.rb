# Requires all the element/* files, with the Base class required first
require_relative 'element/base'

# Thanks to https://gist.github.com/skorks/466442
Dir["#{File.dirname(__FILE__)}/element/**/*.rb"].each {|file| require file }
