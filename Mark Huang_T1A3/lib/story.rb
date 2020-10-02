# frozen_string_literal: true

require 'timeout'
require 'date'
require "yaml"
require_relative 'text_display'
require_relative 'battle'
require_relative 'welcome'

# responsible for navigating game story
class Story < Welcome
  include TextLayout

  def initialize
    @battle = Battle.new
  end

  #saving function
  def process_check
    @@process += 1
    case @@process
    when 1
      story_two
    when 2
      story_three
    end
  end

  def save_or_not
    prompt = TTY::Prompt.new
    save_choice = prompt.select('*** Do you want to save the game now? ***'.yellow, ['yep'.red, 'nope'.blue])
      if save_choice == 'yep'.red
        save(@@play.player_name)
      elsif save_choice == 'nope'.blue
        puts "that's fine, enjoy your journey."
        next_line
      end
  end

  def save(name)
    time = Time.now.strftime("%k%M_%d%m%Y") 
    @filename = "#{name}_#{time.to_s}.yml"
    savefile = File.open("../Mark Huang_T1A3/savedata/#{@filename}", "w") { |file| file.write(@@process.to_yaml) }
    puts "*** Game saved ***".yellow
    #record playername, time, and process(chapter) number
    #write it into a yaml file? 
    #can only save after each battle(story)
  end

  def list_of_saves
    @savelist = []
      Dir.foreach('../Mark Huang_T1A3/savedata/') do |item|
        @savelist << item
      end
    @savelist.select! {|item| item =~ /.yml\b/}
    @savehash = {}
    i = 0
      @savelist.each do |x|
        i += 1
        @savehash[i] = x.to_s
        puts "#{i}. #{@savehash[i]}"
      end
      @list_length = i
  end

  def load 
    puts "===== List of Save Data =====".yellow
    list_of_saves
    puts "*** Choose a file by typing in its number ***".yellow
    while true
      save_index = gets.chomp.to_i
      if (save_index.is_a? Numeric) && save_index <= @list_length && save_index > 0
        load_file(@savehash[save_index])
        break
      else
        puts "That's not a vaild number, please type in again.".yellow
      sleep(0.5)
      end
    end
    
  end

  def load_file(filename)
    loadsave = File.open("../Mark Huang_T1A3/savedata/#{filename}", 'r') { |file| YAML::load(file) }
    @@process = loadsave
    puts "===== Save file successfully loaded =====".yellow
    process_check
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

  def story_one
    puts 'You went to parachuting and was blown into a huge jungle by a tornado that came from nowhere. Luckily, you had a soft landing and you were not hurt!'
    next_line
    # input 3
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
    # input 4
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
      process.save_or_not
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
    # input 5
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
    puts '"I come from Melbourne, so let\'s try if you can type "I love Melbourne!" in 3 seconds!"'.yellow
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
    puts 'The guy transforms into a fire element🔥 and attacked you!'
    next_line
    @battle.battle_process('2')
    # to be continued
  end

  def timed_quest
    puts '"Press enter if you are ready"'
    next_line
    Timeout.timeout(3) do
      @text = gets.chomp
      @text = @text
    end
  rescue Timeout::Error
    puts ""
    puts "That's too slow mate! Try again."
    retry
  else
    if @text != 'I love Melbourne!'
      puts 'Nuh-uh, found typo there, try again.'
      next_line
      timed_quest
    end
    puts 'Wow you did it! You must love Melbourne just like me.'
  end

  def story_three
    puts 'boss storyline'
  end
end
