# Four battles, including one boss fight
# six options, 2 irrelevant and 4 critical options
# story logic and conditions
require_relative 'text_display'
require_relative 'battle'

class Story
  include TextLayout

  def initialize
    @battle = Battle.new
  end

  def story_one
    puts 'You went to parachuting and was blown into a huge jungle by a tornado that came from nowhere. Luckily, you had a soft landing and you were not hurt!'
    next_line
    prompt = TTY::Prompt.new
    choice1 = prompt.select('*** Now you want to ***', ['Explore the jungle'.red, 'Rest'.blue])

    if choice1 == 'Explore the jungle'.red
      clear_screen
      puts '*** Explore the jungle'.red
      puts "It's nice and brisk. There are low, puffy, dark grey clumps of clouds in the sky, and it's a nice day out."
      next_line
      puts 'While you travel through the jungle, you see a dry creekbed. You notice brightly, colored berries. Up ahead, you see a peculiar tent, which looks to have been occupied previously by some miners or prospectors.'
      next_line
      prompt = TTY::Prompt.new
      choice2 = prompt.select('*** You want to ***', ['Go check the tent'.red, 'Leave it and move on'.blue])
      if choice2 == 'Go check the tent'.red
        clear_screen
        puts '*** Go check the tent'.red
        puts 'The moment you step into the tent, a cobra comes at you!'
        next_line
        @battle.battle_process('1')
      elsif choice2 == 'Leave it and move on'.blue
        puts 'story_two'
      end

    elsif choice1 == 'Rest'.blue
      clear_screen
      puts '*** Rest'
      puts 'You took a nap and woke up at night. Suddenly, you found yourself surrounded by a group of hungry wolves, you fought your best but still got outnumbered.'
      next_line
      prompt = TTY::Prompt.new
      death_choice = prompt.select('*** You died ***', ['Play again', 'Exit'])
      if death_choice == 'Play again'
        puts 'run the game again yourself'
      elsif death_choice == 'Exit'
        exit
      end
    end
  end
end

# need user input to solve a puzzle
# def story_two

# end
