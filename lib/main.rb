require_relative 'location_builder'
require_relative 'runner'
require_relative 'music_box'

include LocationBuilder

MusicBox.init

puts
puts
puts "Welcome to a story by P. Ennemoser. Enter 'help' at any time."
puts '--------------------------------------------------------------'
puts

locations = parse_file('data/chapter_0.rb')

runner = Runner.new
runner.locations = locations

runner.run
