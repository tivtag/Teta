require_relative 'location_builder'
require_relative 'runner'

include LocationBuilder

puts "Parsing..!"
locations = parse('data/chapter_1.rb')
puts "done! "
puts locations.to_s

runner = Runner.new
runner.locations = locations
runner.location = locations[1] #.first

runner.run 
