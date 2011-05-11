# This file is started initially when using Ocra compiled .exe on Windows.

GAMEROOT = File.dirname($PROGRAM_NAME)
ENV['PATH'] = File.join(GAMEROOT,"lib") + ";" + ENV['PATH']

begin  
  if not defined?(Ocra)
    Dir.chdir File.join(GAMEROOT,"lib")
  end
 
  require_relative 'lib/main.rb'
rescue Exception => e
  puts e.message
end

