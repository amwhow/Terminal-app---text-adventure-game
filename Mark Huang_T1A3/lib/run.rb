# frozen_string_literal: true

# run the app
require_relative 'story.rb'
require_relative 'welcome.rb'
require_relative 'text_display.rb'
require_relative 'battle.rb'

@@play = Welcome.new
@@play.menu

# def help_docs 
#   puts "Hitting any key to continue the story."
#   puts "Making choices from the prompt menu."
#   puts "Follow the in-game instruction and enjoy your journey!"
# end

# if ARGV[0] == "-h" || ARGV[0] == "--help"
#   help_docs
#   exit
# end
