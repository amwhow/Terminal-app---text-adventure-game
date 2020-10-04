# frozen_string_literal: true

# take care of battle run and showing status
require 'colorize'
require 'io/console'
require 'tty-prompt'
require 'artii'
require_relative 'text_display'
require_relative 'story'
require_relative 'welcome'


# define how a battle will go
class Battle < Welcome
  attr_accessor :player, :enemy, :process
  include TextLayout
  extend TextLayout

  def initialize
    $game_process = 0
    # $battle_statistics
    @player = { name: @@play.player_name.to_s, atk: 10, hp: 45, escape: 0 }
    @enemy = { '1' => { name: 'Cobra', atk: 5, hp: 20, atk_bonus: 5 }, '2' => { name: 'Fire Element', atk: 8, hp: 40, atk_bonus: 7, item: 'Fire essence' }, '3' => { name: 'Donkey Kong', atk: 10, hp: 100, item: "'Donkey Kong Country: Tropical Freeze'" } }
  end

  def battle_routine
    clear_screen
    puts "--- YOUR HP: #{@player[:hp]}/45 ---".light_blue
    prompt = TTY::Prompt.new
    @choice = prompt.select('*** Your action ***', ['Attack⚔️'.red, 'Escape🏃‍♂️'.green])
  end

  # calculate enemy damage
  def enemy_attack(num)
    enemy_damage = @enemy[num.to_s][:atk] + rand(-2..2)
    framed_narration("#{@enemy[num.to_s][:name]} dealt #{enemy_damage} damage!")
    @player[:hp] -= enemy_damage
    sleep(2)
    clear_screen
  end

  # calculate player damage
  def player_attack(num)
    player_damage = @player[:atk] + rand(-2..2)
    framed_narration("You dealt #{player_damage} damage!")
    @enemy[num.to_s][:hp] -= player_damage
    sleep(2)
    clear_screen
  end

  # decide whether player hp <= 0
  def player_dead_decide
    if @player[:hp] <= 0
      puts 'You died...🤷‍♂️'
      next_line
      dead_story = Story.new
      dead_story.dead_end
    end
  end

  # battle outcome prompt
  def battle_result(num)
    clear_screen
    framed_narration('You win!')
    sleep(2)
    next_line
    clear_screen
    if $game_process < 2
      framed_narration("After beating the #{@enemy[num.to_s][:name]}, you felt you are stronger now.(atk + #{@enemy[num.to_s][:atk_bonus]})")
      @player[:atk] += @enemy[num.to_s][:atk_bonus]
      next_line
      clear_screen
      # framed_narration("You found -- #{@enemy[num.to_s][:item]}.") if @enemy[num.to_s][:item]
    end
  end

  # print different after battle event
  def after_battle_effect
    case $game_process
    when 0
      framed_narration('After having a quick break in the tent, you felt refreshed.(HP restored)')
      @player[:hp] = 45
    when 1
      framed_narration('You had a BBQ around the campfire and felt energised to move on. (HP restored)')
      @player[:hp] = 45
    when 2
      framed_narration('Donkey Kong fainted, and the illusion of the Jungle was expelled.')
      next_line
      framed_narration('Congrats! you have completed the game!')
      next_line
      framed_narration('Thanks for playing! See you in the future!')
      next_line
      framed_narration('-- Mark Huang')
      exit
    end
  end

  # main battle process
  def battle_process(num)
    while @player[:hp] >= 0 && @enemy[num.to_s][:hp] >= 0
      battle_routine
      if @choice == 'Attack⚔️'.red
        player_attack(num)
        # decide whether enemy dead or not
        break if @enemy[num.to_s][:hp] <= 0
      elsif @choice == 'Escape🏃‍♂️'.green
        if @player[:escape] + rand(1..10) > 3
          framed_narration('You escaped successfully! 💨💨💨')
          sleep(2)
          break
        else
          framed_narration('You failed to escape! 🙉🙉🙉')
          sleep(2)
        end
      end
      enemy_attack(num)
      player_dead_decide
    end
    if @player[:hp] <= 0 || @enemy[num.to_s][:hp] <= 0
      battle_result(num)
      $game_process = num.to_i - 1
      after_battle_effect
    end
    battle = Story.new
    next_line
    battle.save_or_not
    battle.process_check
  end
end
