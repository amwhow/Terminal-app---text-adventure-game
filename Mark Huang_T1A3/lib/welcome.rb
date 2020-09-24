require "tty-prompt"
require "io/console"


class Welcome

  def clear_screen
    system("clear")
  end

# Code credit: https://stackoverflow.com/questions/34594018/how-to-code-press-key-to-continue/34594382
  def next_line 
    puts "(Press any key to continue)"
    STDIN.getch
    # puts "                                    \r"
  end

  def newgame_welcome
    clear_screen
    puts "Presented by: Mark Huang".center(100)
    sleep(3)
    clear_screen
    print "Welcome to the Jungle, adventurer"
    next_line
    puts "May I know your name?"
    print ">"
    player_name = gets.chomp
    clear_screen
    puts "Greetings, #{player_name}. Your Jungle trip starts now..."
  end

  def initialize
    clear_screen
    prompt = TTY::Prompt.new
    user_welcome_choice = prompt.select("*** Welcome to the great text adventure game - Jungle Run! ***", %w(Newgame Load Exit))
    # sleep(0.5)
    # system("afplay ./lib/Kalimdor.mp3")
      case user_welcome_choice
        when "Newgame"
          newgame_welcome
        when "Load"
          load_page
        when "Exit"
          clear_screen
          puts "The jungle is always here for you, so long"
          exit
      end
  end

  def load_page
    prompt = TTY::Prompt.new
    user_load_choice = prompt.select("*** Please select your save slot ***", %w(Save1 Save2 Save3))
      case user_load_choice
        when "Save1"
          puts "this is Save1"
        when "Save2"
          puts "this is Save2"
        when "Save3"
          puts "this is Save3"
      end
      
  end
end

Welcome.new



