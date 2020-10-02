# frozen_string_literal: true

# run the app
require_relative 'story.rb'
require_relative 'welcome.rb'
require_relative 'text_display.rb'
require_relative 'battle.rb'

@@play = Welcome.new
@@play.menu
