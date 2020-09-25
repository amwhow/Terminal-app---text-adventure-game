# Display a table to show player option and status
require 'tty-prompt'
# center the text horizontally and vertically
module TextLayout  
  extend self
  def clear_screen
    system('clear')
  end

  # Code credit: https://stackoverflow.com/questions/34594018/how-to-code-press-key-to-continue/34594382
  def next_line
    STDIN.getch
    # puts "                                    \r"
  end
  
  # horizontally center the text
  def center_format(sentence)
    system("clear")
    align_vertically
    puts sentence.center(112)
    sleep(2)
  end
  
  # vertically center the text
  def align_vertically
    14.times do
    puts ""
    end
  end

  def framed_narration(sentence)
    puts "=============================================================================================================="
    12.times do
      puts ""
    end
    puts sentence.center(112)
    12.times do
      puts ""
    end
    puts "=============================================================================================================="
  end

end

