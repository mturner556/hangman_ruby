require_relative "display.rb"
require_relative "file_saving.rb"
require_relative "file_loading.rb"


class Hangman
  include Display
  include FileSaving
  include FileLoading

  attr_accessor :word, :hidden_word, :num_of_guesses, :player_guess, :guesses

  def initialize
    @word = random_word
    @hidden_word = ''
    @word.length.times { @hidden_word << '_' }
    @num_of_guesses = 0
    @player_guess = ''
    @guesses = []
  end

  # this method will generate a random word to use
  def random_word
    txt = 'google-10000-english-no-swears.txt'
    list = []
    file = File.open(txt)
    until file.eof?
      line = file.readline.strip
      list.push(line) if line.length >= 5 && line.length <= 12
    end

    @word = list.sample
  end

  # this will start a new game or load a previous game
  def start_game
    start_instructions
    input = gets.chomp
    input == '1' ? play : load
  end

  # plays a single round of Hangman
  def play
    puts @word
    puts @hidden_word
    @player_guess = gets.chomp.strip.downcase
    validate_guess(@player_guess)
  end

  # validate the player's guess
  def validate_guess(guess)
    if guess.length == 1 && guess.match(/[a-z]/)
      puts "valid input"
    elsif guess == 'save'
      save
    else
      puts "Invalid input"
    end
  end

  # checks if character is in the word
  def correct_letter(letter)
    @word.include?(letter) ? #reveal_letter(letter) && @guesses.push(letter) : @guesses.push(letter) && num_of_guesses += 1
  end

  def game_loop
    until num_of_guesses == 5
      play
    end
  end 
end

game = Hangman.new
game.play
