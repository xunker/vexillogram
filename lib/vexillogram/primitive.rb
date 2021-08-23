# Requires all the primitive/* files, with the Base class required first
require_relative 'primitive/base'

# Thanks to https://gist.github.com/skorks/466442
Dir["#{File.dirname(__FILE__)}/primitive/**/*.rb"].each {|file| require file }
