# frozen_string_literal: true

require 'timeout'
require 'date'
require 'yaml'
require_relative 'text_display'
require_relative 'battle'
require_relative 'welcome'

# responsible for navigating game story
class Story < Welcome
  include TextLayout
  attr_accessor :battle

  def initialize
    # @battle = Battle.new
  end

  # saving function
  def process_check
    $game_process += 1
    case $game_process
    when 1
      story_two
    when 2
      $battle_statistics.player[:escape] = -10
      story_three
    end
  end

  def save_or_not
    prompt = TTY::Prompt.new
    save_choice = prompt.select('*** Do you want to save the game now? ***'.yellow, ['yep'.red, 'nope'.blue])
    if save_choice == 'yep'.red
      save(@@play.player_name)
      next_line
    elsif save_choice == 'nope'.blue
      puts "that's fine, enjoy your journey.".yellow
      next_line
      clear_screen
    end
  end

  def save(name)
    time = Time.now.strftime('%k%M_%d%m%Y')
    @filename = "#{name}_#{time}.yml"
    File.open("../Mark Huang_T1A3/savedata/#{@filename}", 'w') do |file|
      file.write($battle_statistics.to_yaml)
      file.write($game_process.to_yaml)
    end
    puts '*** Game saved ***'.yellow
  end

  def list_of_saves
    @savelist = []
    Dir.foreach('../Mark Huang_T1A3/savedata/') do |item|
      @savelist << item
    end
    @savelist.select! { |item| item =~ /.yml\b/ }
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
    puts '===== List of Save Data ====='.yellow
    list_of_saves
    puts '*** Choose a file by typing in its number ***'.yellow
    loop do
      save_index = gets.chomp.to_i
      if (save_index.is_a? Numeric) && save_index <= @list_length && save_index.positive?
        load_file(@savehash[save_index])
        break
      else
        puts "That's not a vaild number, please type in again.".yellow
        sleep(0.5)
      end
    end
  end

  def load_file(filename)
    file_array = []
    loadsave = YAML.load_stream(File.read("../Mark Huang_T1A3/savedata/#{filename}")) { |file| file_array << file }
    $battle_statistics = file_array[0]
    $game_process = file_array[-1]
    puts '===== Save file successfully loaded ====='.yellow
    next_line
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

  def self.create_battle
    $battle_statistics = Battle.new
  end

  def story_one_branch_one_b1
    prompt = TTY::Prompt.new
    choice2 = prompt.select('*** You want to ***', ['Go check the tent'.red, 'Leave it and move on'.blue])
    if choice2 == 'Go check the tent'.red
      clear_screen
      puts '*** Go check the tent'.red
      puts 'The moment you step into the tent, a cobra comes at you!'
      next_line
      # first time Battle.new called
      Story.create_battle.battle_process('1')
    elsif choice2 == 'Leave it and move on'.blue
      # not working
      Story.create_battle
      story = Story.new
      story.save_or_not
      story.process_check
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
      clear_screen
    end
    clear_screen
    puts 'You two sat next to a big campfire.'
    next_line
    puts 'While you were having a chat with the guy, you felt some sprinkles falled on you.'
    next_line
    puts 'The man turned to you and say "You know what, it is a bit boring just sitting here and wait, how about we play a game?"'
    next_line
    puts '"I come from Melbourne, so let\'s try if you can type "I love Melbourne!" in 3 seconds!"'.yellow
    timed_quest
    rows, columns = $stdout.winsize
    columns.times do
      print '='
    end
    next_line
    clear_screen
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
    $battle_statistics.battle_process('2')
  end

  def timed_quest
    puts '"Press enter if you are ready"'
    next_line
    Timeout.timeout(6) do
      @text = gets.chomp
      @text = @text
    end
  rescue Timeout::Error
    puts ''
    @answer = "That's too slow mate! Try again."
    puts @answer
    retry
  else
    if @text != 'I love Melbourne!'
      @answer = 'Nuh-uh, found typo there, try again.'
      puts @answer
      next_line
      timed_quest
    else @text == 'I love Melbourne!'
         @answer = 'Wow you did it! You must love Melbourne just like me.'.yellow
         puts @answer
    end
  end

  def story_three
    puts 'You were back on track, going to the deep of the jungle.'
    next_line
    puts 'Suddenly, you felt the jungle was shaking.'
    next_line
    puts '.'
    next_line
    puts '..'
    next_line
    puts '...'
    next_line
    puts 'Bang! Something huge smashed on the land behind you.'
    next_line
    puts 'and it\'s DONKEY KONG!!!'
    next_line
    if $battle_statistics.player[:atk] < 20
      puts '--"You are not PREPARED!!"--🦍🦍🦍'
      next_line
    else
      puts '"Is that you who killed all of my lackeys?!"'
      next_line
      puts '"That\'s ridiculous, but this is your end💢"'
      next_line
    end
    $battle_statistics.battle_process('3')
  end
end
