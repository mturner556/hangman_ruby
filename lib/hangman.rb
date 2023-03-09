require_relative "display.rb"
require_relative "file_saving.rb"

class Game
  include Display
  include FileSaving

  attr_accessor :word, :key, :guesses, :guess

  def initialize
    @word = ''
    @key = ''
    @guesses = []
    @guess = ''
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

    loop do 
      display
      player_guess
      store_guess(@guess)
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

  # gets the player's guess
  def player_guess
    puts 'Enter your guess. Choose a letter from a-z:'
    loop do 
      guess = gets.chomp.downcase
      if valid_guess(guess) == true
        @guess = guess
      elsif valid_guess(guess) == false
        FileSaving.new.save
      else
        valid_guess(guess)
      end
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

  # checks the player's guess. If the player's guess is correct, update the masked word with the correct letters
  def valid_guess(input)
    if input.length == 1 && input == 'a'..'z'
      true
    elsif input == 'save'
      false
    else
      'Input Error. Try again.'
    end
  end
end

hangman = Game.new
# hangman.start
hangman.player_guess
