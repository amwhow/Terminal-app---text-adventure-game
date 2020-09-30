# text decoration, introduction and aligning function
module TextLayout
  def clear_screen
    system('clear')
  end

  # Code credit: https://stackoverflow.com/questions/34594018/how-to-code-press-key-to-continue/34594382
  # STDIN stands for standard input, requires io/console
  # getch reads and returns a character in raw mode without pressing enter
  def next_line
    STDIN.getch
    # puts "                         \r"
  end

  def framed_narration(sentence)
    system('clear')
    rows, columns = $stdout.winsize
      columns.times do
        print '='
      end
      (rows / 2 - 1).times do
        puts ''
      end
    puts sentence.center(columns)
      (rows / 2 - 1).times do
        puts ''
      end
      columns.times do
        print '='
      end
  end
end
