# Four battles, including one boss fight
# six options, 2 irrelevant and 4 critical options
# story logic and conditions
require_relative 'text_display.rb'
require_relative 'battle.rb'

class Story
extend TextLayout

  def initialize
    @s1c1
    @s1c2
    @death_choice
  end
  
  def self.story_one
    @prompt = TTY::Prompt.new
    puts "You went to parachuting and was blown into a huge jungle by a tornado that came from nowhere. Luckily, you had a soft landing and you were not hurt!"
    Story.next_line
    @s1c1 = @prompt.select('*** Now you want to ***', ["Explore the jungle".red, "Rest".blue])

    if @s1c1 == "Explore the jungle"
      Story.clear_screen
      puts "*** Explore the jungle"
      puts "It's nice and brisk. There are low, puffy, dark grey clumps of clouds in the sky, and it's a nice day out."
      Story.next_line
      puts "While you travel through the jungle, you see a dry creekbed. You notice brightly, colored berries. Up ahead, you see a peculiar tent, which looks to have been occupied previously by some miners or prospectors."
      Story.next_line
      @s1c2 = @prompt.select('*** You want to ***', ["Go check the tent", "Leave it and move on"])
        if @s1c2 == "Go check the tent"
          Story.clear_screen
          puts "*** Go check the tent"
          puts "The moment you step into the tent, a cobra comes at you!"
          Story.battle
        elsif @s1c2 == "Leave it and move on"
          puts "story_two"
        end

    elsif @s1c1 == "Rest"
      Story.clear_screen
      puts "*** Rest"
      puts "You took a nap and woke up at night, surrounded by a group of hungry wolves, you fought your best but still got outnumbered."
      Story.next_line
      @death_choice = @prompt.select('*** You died ***', ["Play again", "Exit"])
        if @death_choice == "Play again"
          puts "run the game again yourself"
        elsif @death_choice == "Exit"
          exit
        end
    end
  end
end