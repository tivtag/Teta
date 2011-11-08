require 'rake'

Gem::Specification.new do |s|

  s.platform = Gem::Platform::RUBY
  s.name = 'teta'
  s.version = '0.1.2'
  s.summary = 'Ruby TExT Adventure'
  s.description = 'A cross-platform text adventure written in Ruby that uses a Domain Specific Language to describe the story.'
  s.author = 'Paul Ennemoser'
  s.email = 'tick@federrot.at'
  s.homepage = 'http://paul.federrot.at/'
  s.executables = ['teta'] 
  s.require_paths = ["lib"]
  s.bindir = 'bin'
  s.files = FileList['lib/*.rb', 'lib/**/*.rb', 'bin/*', 'story/*.rb', 'media/**/*'].to_a

end

