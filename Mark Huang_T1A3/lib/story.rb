# Four battles, including one boss fight
# six options, 2 irrelevant and 4 critical options
# story logic and conditions
require 'io/console'
require 'timeout'
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
      story_one_branch_one
      story_one_branch_one_b1
    elsif choice1 == 'Rest'.blue
      story_one_branch_one_b2
    end
  end

  def story_one_branch_one
    clear_screen
    puts '*** Explore the jungle'.red
    puts "It's nice and brisk. There are low, puffy, dark grey clumps of clouds in thesky, and it's a nice day out."
    next_line
    puts 'While you travel through the jungle, you see a dry creekbed. You noticebrightly, colored berries. Up ahead, you see a peculiar tent, which looks to havebeen occupied previously by some miners or prospectors.'
    next_line
  end

  def story_one_branch_one_b1
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
  end

  def story_one_branch_one_b2
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

  def story_two
    clear_screen
    puts 'You kept on walking into the jungle, the wind blew like jumping owls.'
    next_line
    puts 'Then you saw something in the distance, or rather someone.'
    next_line
    puts 'It appeared a figure of a man.' 
    next_line
    puts '"Hey! never seen a human here, looking for something?", the man said.'
    next_line
    puts '"You know what, I just set my fire up, up for some hotpot and tell me your story?"'
    next_line
    prompt = TTY::Prompt.new
    choice1 = prompt.select('*** You want to ***', ['Go with him'.red, 'Refuse'.blue])
      if choice1 == 'Refuse'.blue
        puts '"Come on, you are gonna love it!", man said.'
        next_line
      end
        puts 'You two sat next to a big campfire.'
        next_line
        puts 'While you were having a chat with the guy, you felt some sprinkles falled on you.'
        next_line
        puts 'The man turned to you and say "You know what, it is a bit boring just sitting here and wait, how about we play a game?"'
        next_line
        puts '"I come from Melbourne, so let\'s try if you can type "I love Melbourne!" in 3 seconds!"'
        
        timed_quest
        next_line
        puts '"Well done mate, and I think it\'s ready now.", man appeared satisfying.'
        next_line
        puts '"What\'s ready?", you asked.'
        next_line
        puts '"My meat, it\'s well marinated now..."'
        next_line
        puts '"Oh, did I mention I am making human hotpot today?"'
        next_line
        puts 'The guy transforms into a fire element and attacked you.'
        next_line
        battle_process('2')
        # to be continued
  end
  
  def timed_quest
    begin
      puts '"Press enter if you are ready"'
      # STDIN will conflict with gets.chomp, making the input unwanted result.
      next_line
      Timeout::timeout(3) {
        @text = gets.chomp
        aaa = 1
      }
    rescue Timeout::Error
      puts "That's too slow mate! Try again."
      retry
    else
      if @text != "I love Melbourne!"
        puts "Nuh-uh, found typo there, try again."
        next_line
        timed_quest
      end
      puts "Wow you did it! You must love Melbourne as well."
    end
  end

  def story_three
    puts "boss storyline"
  end

end


