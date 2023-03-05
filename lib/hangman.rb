require_relative "display.rb"
require_relative "file_saving.rb"

class Game
  include Display
  include FileSaving
  attr_accessor :word, :key, :guesses, :player_guess

  def initialize
    @word = ''
    @key = []
    @guesses = []
    @player_guess = ''
  end

  def start
    puts 'Would you like to play hangman?'
    puts 'Press 1 to "Start" or 2 to "Load Game"'
    gets.chomp == '1' ? play_game : load_game
  end

  # plays the game
  def play_game
    random_word
    mask
    
    while @key != @word do
      display
      player_input
    end
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

  # will mask the random word from the player
  def mask
    @key = @word.gsub(/./, '*')
  end

  # will store the guesses the player made
  def store_guess(guess)
    @guesses << guess
  end

  # checks the player's guess
  def check_guess

  end
end

hangman = Game.new
hangman.start
