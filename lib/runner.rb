require_relative 'input_output'
require_relative 'location'
require_relative 'help_system'
require_relative 'action_container'
require_relative 'game_context'
require_relative 'string_ext'
require_relative 'dsl/loader'
require_relative 'mechanics/all'

include DSL::Loader

class Runner < GameContext
  include ActionContainer
  include InputOutput
  include Mechanics::LookAt
  include Mechanics::Goto

  attr_reader :previous_location
  attr_accessor :locations, :location

  DEBUG = true
  STORY_FOLDER = "../story/"

  def initialize
    super
  
    @player  = Player.new
    @help    = HelpSystem.new
    @running = true

    add_action :q, :quit, :exit do
      @running = false
    end

    add_action :help do |cmd|
      @help.call cmd
    end
    
    add_action :go do |dir|
      go dir
    end

    add_action :i, :inv do
      show_inv
    end

    add_action :g, :goto do |location|
      goto location
    end

    add_action :l, :look, :lookat do |obj| 
      lookat obj
    end
 
    add_action :cls do
      system('clear') 
    end

    if DEBUG then
      add_action :music do |name|
        MusicBox::play name
      end

      add_action :changechapter do |index|
        change_to_chapter index
        print_location
      end
    end
  end

  def run
    print_location

    while @running do
      step
    end
  end

  def change_to_chapter(index)
    @locations = parse_file "#{STORY_FOLDER}/chapter_#{index}.rb"
    @location = nil

    change_location locations.first
  end

  def die(reason = 'You died..')
     puts reason
     @running = false
  end

private
  def step
      handle read_input
  end

  def handle(input)
    entries = input.downcase.split ' '
   
    if entries.length > 0 then
      action = entries.first.intern
      args   = entries[1..entries.length]
   
      if not handle_action(action, args) then
        puts "Huh..?"
      end
    end
  end

  def handle_action(action, args)
    location.eval_action_safe(action, *args) or self.eval_action_safe(action, *args)
  end

  def print_location  
    print_text @location.description 
  end

  def change_location(loc)
    @previous_location = @location

    @location = loc
    setup_location

    transition = @location.find_transition_from(@previous_location)
    if transition != nil then
      transition.enter()
      puts transition.text unless transition.text.nil?
    end
  end

  def setup_location
    @location.context = self
  end

  def show_inv
    if player.items.length > 0 then
      @player.items.each do |item|
        puts "1x #{item.long_name}"
      end
    else
      puts '~ empty ~'
    end
  end

end

