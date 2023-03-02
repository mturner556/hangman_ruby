class Game
  attr_accessor :word, :key, :guesses

  def initialize
    @word = ''
    @key = ''
    @guesses = []
    @player_guess = ''
  end

  def start
    puts 'Would you like to play hangman?'
    puts 'Press 1 to "Start" or 2 to "Load Game"'
    gets.chomp == '1' ? turn : load_game
  end

  # selects a random word and assigns it to the @word variable
  def random_word
    txt = 'google-10000-english-no-swears.txt'
    list = []
    file = File.open(txt)
    until file.eof?
      line = file.readline.strip
      line.length >= 5 && line.length <= 12 ? list.push(line) : nil
    end

    @word = list.sample
  end

  # gets the player's input
  def player_input
    player_guess = gets.chomp

    if player_guess.length == 1
      @player_guess = player_guess
      store_guess(@player_guess)
    elsif player_guess == 'save'
      save_game
    else
      puts 'Input ERROR'
    end
  end

  # plays rounds of the game until the guesses match the @word
  def turn
    display
    player_input
  end

  # will save the state of the game
  def save_game
    puts "Save ERROR"
  end

  # loads a saved game
  def load_game
    puts 'Load ERROR'
  end

  # will mask the random word from the player
  def mask
    @key = @word.gsub(/./, '*')
    "#{@key}\n"
  end

  # will store the guesses the player made
  def store_guess(guess)
    puts @guesses.is_a? Array
  end

  # checks the player's guess
  def check_guess

  end

  def display
    puts "Save game by pressing 'save'"
    puts "#{mask}"
    puts "__________"
    puts "#{guesses}"
  end
end

hangman = Game.new
hangman.store_guess("a")
