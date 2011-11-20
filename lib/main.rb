require_relative 'runner'
require_relative 'music_box'

MusicBox.init

puts
puts
puts "Welcome to a story by P. Ennemoser. Enter 'help' at any time."
puts '--------------------------------------------------------------'
puts

runner = Runner.new

if not defined?(Ocra)
  if ARGV.empty? then
    runner.change_to_chapter 0
  else
    runner.load_file ARGV[0]
  end

  runner.run
end
