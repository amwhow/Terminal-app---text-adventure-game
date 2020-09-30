# frozen_string_literal: true

# take care of battle run and showing status
require 'colorize'
require 'io/console'
require 'tty-prompt'
require_relative 'text_display'
require_relative 'story'
require_relative 'welcome'

# define how a battle will go
class Battle < Welcome
  attr_accessor :player, :enemy
  include TextLayout
  extend TextLayout

  def initialize
    @player = { name: 'player_name', atk: 9, hp: 45, escape: 0 }
    @enemy = { '1' => { name: 'Cobra', atk: 5, hp: 20, atk_bonus: 5 }, '2' => { name: 'Robber', atk: 8, hp: 35, atk_bonus: 7, item: 'dagger' }, '3' => { name: 'Donkey Kong', atk: 15, hp: 100, item: "Nintendo Switch game: 'Donkey Kong Country: Tropical Freeze'" } }
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
    framed_narration("After beating the #{@enemy[num.to_s][:name]}, you felt you are stronger now.(atk + #{@enemy[num.to_s][:atk_bonus]})")
    @player[:atk] += @enemy[num.to_s][:atk_bonus]
    next_line
    clear_screen
    framed_narration("You found -- #{@enemy[num.to_s][:item]}.") if @enemy[num.to_s][:item]
  end

  # print different after battle event
  def after_battle_effect
    case @@process
    when 0
      framed_narration('Having a quick break in the tent, you felt refreshed.(HP restored)')
      @player[:hp] = 45
    when 1
      puts 'story 2 after battle result'
    when 2
      puts 'go to ending'
    end
    # could add error handling here?
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
      after_battle_effect
    end
    process = Story.new
    process.process_check
  end
end
