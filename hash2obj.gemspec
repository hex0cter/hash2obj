$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'version'

Gem::Specification.new do |s|
  s.name        = 'hash2obj'
  s.version     = Hash2Obj::VERSION
  s.summary     = 'Convert a hash into a Ruby object'
  s.description = 'Apply a hash into a Ruby object and return another instance of the same class using the data in the hash.'
  s.authors     = ['Daniel Han']
  s.email       = 'hex0cter@gmail.com'
  s.homepage    = 'https://github.com/hex0cter/hash2obj'
  s.license     = 'MIT'
  s.files       = Dir['lib/**/*']
  s.required_ruby_version = '>= 2.1.0'
  s.require_paths = ['lib']
end
