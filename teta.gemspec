require 'rake'

Gem::Specification.new do |s|

  s.platform = Gem::Platform::RUBY
  s.name = 'teta'
  s.version = '0.1.1'
  s.summary = 'Ruby TExT Adventure'
  s.description = 'A cross-platform text adventure written in Ruby that uses a Domain Specific Language to describe the game data.'
  s.author = 'Paul Ennemoser'
  s.email = 'tick@federrot.at'
  s.homepage = 'http://tickblog.wordpress.com'
  s.executables = ['teta'] 
  s.require_paths = ["lib"]
  s.bindir = 'bin'
  s.files = FileList['lib/*.rb', 'lib/**/*.rb', 'bin/*', 'media/**/*'].to_a

  puts
  puts s.files
  puts
end
