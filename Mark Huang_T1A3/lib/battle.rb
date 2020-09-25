# take care of battle run and showing status
require 'colorize'
require 'tty-prompt'
require_relative 'text_display'

# define how a battle will go
class Battle
  attr_accessor :player, :enemy
  include TextLayout
  extend TextLayout

  def initialize
    @player = { name: 'player_name', atk: 9, hp: 45 }
    @enemy = { '1' => { name: 'Cobra', atk: 5, hp: 20 }, '2' => { name: 'Robber', atk: 8, hp: 35 }, '3' => { name: 'Fire element', atk: 10, hp: 50 }, '4' => { name: 'Donkeykong', atk: 15, hp: 100 } }
  end

  def battle_routine
    Battle.clear_screen
    puts "--- YOUR HP: #{@player[:hp]}/45 ---".light_blue
    prompt = TTY::Prompt.new
    choice = prompt.select('*** Your action ***', ['Attack⚔️'.red, 'Escape🏃‍♂️'.green])
  end

  def battle_process(num)
    while @player[:hp] >= 0 && @enemy[num.to_s][:hp] >= 0
      battle_routine
      if choice == 'Attack⚔️'.red
        # calculate player damage
        @enemy[num.to_s][:hp] -= @player[:atk]
        Battle.framed_narration("You dealt #{@player[:atk] + rand(-2..2)} damage!")
          if @enemy[num.to_s][:hp] <= 0
            break
          end
        sleep(2)
        # calculate enemy damage
        Battle.framed_narration("#{@enemy[num.to_s][:name]} dealt #{@enemy[num.to_s][:atk] + rand(-2..2)} damage!")
        @player[:hp] -= @enemy[num.to_s][:atk]
          if @player[:hp] <= 0
            sleep(2)
            puts "You died..."
            break
          end
        sleep(2)
      elsif choice == 'Escape🏃‍♂️'.green
        puts 'escape'
        Battle.framed_narration(sentence)
        sleep(2)
      end
    end
    Battle.framed_narration 'You win!'
    sleep(2)
    # battle result to be added
  end
end
