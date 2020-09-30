# frozen_string_literal: true

require 'tty-prompt'
require 'io/console'
require 'colorize'
require 'artii'
require_relative 'story'
require_relative 'text_display'

# Welcome menu function
class Welcome
  include TextLayout

  def initialize
    @@process = 0
    @story = Story.new
    @player_name = ''
  end

  def menu
    clear_screen
    system("artii 'J U N G L E   R U N'")
    prompt = TTY::Prompt.new
    user_welcome_choice = prompt.select('*** 🌴 Welcome to Jungle Run 🌴 ***', %w[Newgame Load Exit])
    # sleep(0.5)
    # system("afplay ./lib/Kalimdor.mp3")
    case user_welcome_choice
    when 'Newgame'
      clear_screen
      newgame_welcome
    when 'Load'
      clear_screen
      load_page
    when 'Exit'
      clear_screen
      puts 'The jungle is always here for you, so long.'
      exit
    end
  end

  # Newgame button
  def newgame_welcome
    framed_narration('Presented by: Mark Huang')
    # sleep(3)
    clear_screen
    print 'Welcome to the Jungle, adventurer'
    puts '(Press any key to continue)'
    next_line
    puts 'May I know your name?'
    print '>'
    # add error handling here
    @player_name = gets.chomp
    # .gsub(/[^0-9a-z ]/i, '')
    clear_screen
    puts "Greetings, #{@player_name}. Your Jungle journey starts now..."
    next_line
    clear_screen
    @story.story_one
  end

  # Load button
  def load_page
    prompt = TTY::Prompt.new
    user_load_choice = prompt.select('*** Please select your save slot ***', %w[Save1 Save2 Save3])
    case user_load_choice
    when 'Save1'
      puts 'this is Save1'
    when 'Save2'
      puts 'this is Save2'
    when 'Save3'
      puts 'this is Save3'
    end
  end
end
