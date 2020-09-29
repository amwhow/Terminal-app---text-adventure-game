# Four battles, including one boss fight
# six options, 2 irrelevant and 4 critical options
# story logic and conditions
require_relative 'text_display'
require_relative 'battle'
require_relative 'welcome'

class Story < Welcome
  include TextLayout

  def initialize
    @battle = Battle.new
  end

  def dead_end
    prompt = TTY::Prompt.new
    death_choice = prompt.select('*** 💀 Game over 💀 ***'.yellow, ['Play again', 'Exit'])
      if death_choice == 'Play again'
        play = Welcome.new
        play.menu
      elsif death_choice == 'Exit'
        exit
      end
  end

  def process_check
    @@process += 1
      case @@process
      when 1
        story_two
      when 2
        next_line
        story_three
      end
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
        process = Story.new
        process.process_check
      end

    elsif choice1 == 'Rest'.blue
      clear_screen
      puts '*** Rest'.blue
      puts 'You took a nap and woke up at night.'
      next_line
      puts 'Suddenly, you found yourself surrounded by a group of hungry wolves.'
      next_line
      puts 'You fought your best but still got outnumbered.'
      next_line
      dead_end
    end
  end

  def story_two
    clear_screen
    puts 'You keep on walking into the jungle, the wind blew like jumping owls.'
    next_line
    puts 'Then you saw something in the distance, or rather someone.'
    next_line
    puts 'It appears a figure of a man.' 
    next_line
    puts '"Hey! Never see a human here, looking for something?", the man said.(to be continued...)' 
  end
  
  def story_three
    puts "boss storyline"
  end

end


