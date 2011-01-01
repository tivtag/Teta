require_relative 'location_builder'
require_relative 'runner'
require_relative 'music_box'

include LocationBuilder

puts
puts "Welcome to Teta. Enter 'help' at any time."
puts

MusicBox.init
MusicBox.play 'night'

locations = parse_file('data/chapter_1.rb')

runner = Runner.new
runner.locations = locations
runner.location = locations[0]

runner.run
