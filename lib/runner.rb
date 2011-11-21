require_relative 'input_output'
require_relative 'system_helper'
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

    init_actions
  end

  def run
    step while @running
  end

  def change_to_chapter(index)
    load_file "chapter_#{index}"
  end

  def load_file(name)
    @locations = parse_file "#{STORY_FOLDER}/#{name}.rb"
    @location = nil
    @previous_location = nil

    change_location locations.first
  end

  def die(reason = 'You died..')
     puts
     puts reason

     puts 'Press Enter to exit..'
     gets
     @running = false
  end

private
  def init_actions
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

    add_action :l, :look, :lookat, :examine do |obj| 
      lookat obj
    end
 
    add_action :cls do
      SystemHelper::clear
    end

    if DEBUG then
      add_action :music do |name|
        MusicBox::play name
      end

      add_action :cc, :changechapter do |index|
        change_to_chapter index
      end
    end
  end

  def step
    handle read_input
  end

  def handle(input)
    entries = input.downcase.split ' '
   
    if entries.length > 0 then
      action = entries.first.intern
      args   = entries[1..entries.length]
   
      unless handle_action(action, args)
        puts "Huh..?"
      end
    end
  end

  def handle_action(action, args)
    location.eval_action_safe(action, *args) or self.eval_action_safe(action, *args)
  end

  def print_location
    puts
    puts @location.description 
  end

  def change_location(loc)
    puts caller

    @previous_location = @location
    @location = loc
    setup_location

    transition = @location.transition_from(@previous_location)
    if transition != nil then
      puts transition.text unless transition==true or transition.text.nil?
    else
      throw "Transition from #{previous_location} to #{next_location} not possible."
    end

    print_location
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

