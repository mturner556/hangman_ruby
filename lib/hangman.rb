class Game
  attr_reader :word, :key

  @word = ''
  @key = ''

  def start
    puts 'Would you like to play hangman?'
    puts 'Press 1 to "Start" or 2 to "Load Game"'
    gets.chomp == '1' ? random_word : 'Thank you for playing.'
  end

  def random_word
    # holds google text file
    txt = 'google-10000-english-no-swears.txt'
    # empty array to hold words of a 5-12 char length
    list = []
    # opens file and pushes the word to list array
    file = File.open(txt)
    until file.eof?
      line = file.readline.strip
      line.length >= 5 && line.length <= 12 ? list.push(line) : nil
    end
    # returns a randomly selected word from list
    @word = list.sample
  end
end

hangman = Game.new
hangman.start
