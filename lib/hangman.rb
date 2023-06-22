require_relative "file_saving.rb"
require_relative "file_loading.rb"
require 'yaml'


class Hangman
  include FileSaving
  include FileLoading

  attr_accessor :secret_word, :hidden_word, :num_of_guesses, :guesses_made

  def initialize
    @secret_word = generate_random_word
    @hidden_word = '_' * @secret_word.length
    @num_of_guesses = 10
    @guesses_made = ''
  end

  # generates a random word to use
  def generate_random_word
    txt = 'google-10000-english-no-swears.txt'
    list = []
    file = File.open(txt)
    until file.eof?
      line = file.readline.strip
      list.push(line) if line.length >= 5 && line.length <= 12
    end

    @secret_word = list.sample
  end

  # start game or load a previous game
  def start
    puts "Let's play a game of Hangman!"
    puts "  Press (1) to start a new game"
    puts "  Press (2) to load a previous game"
    input = input_loop
    return play if input == '1'
    return load if input == '2'
  end

  # loops the game until a winner or loser condition is met, or a save condition
  def play
    until @hidden_word == @secret_word || @num_of_guesses == 0
      puts "Number of guesses left: #{num_of_guesses}"
      puts "Guesses you have made: #{guesses_made}"
      puts @hidden_word

      guess = guess_input
      return save if guess == 'save'
      letter_in_secret_word(guess)
    end

    return winner if @hidden_word == secret_word
    return loser if @num_of_guesses == 0
  end

  def input_loop
    input = player_input

    until input == '1' || input == '2' do
      puts 'Invalid input. Please enter (1) or (2).'
      input = player_input
    end

    input
  end

  # gets the player's input
  def player_input
    gets.chomp.downcase.strip
  end

  # checks the player's guess meets specific conditions
  def guess_input
    print 'Choose a letter between a-z, or type "save": '
    input = player_input

    until (input.length == 1 && input.match(/[a-z]/)) || input == 'save'
      puts 'Please enter a valid input. '
      input = player_input
    end

    input
  end

  # checks if the guessed letter is in the @secret_word
  def letter_in_secret_word(guess)
    arr = @secret_word.split('')
    
    if arr.include?(guess)
      arr.each_index do |i|
        if arr[i] == guess
          @hidden_word[i] = guess
          @guesses_made << guess
        end
      end
    else
      @guesses_made << guess
      @num_of_guesses -= 1
    end
  end

  def winner
    puts 'You have won the game!'
    puts "You guessed the secret word: #{@seceret_word}"
    play_again
  end

  def loser
    puts 'You have lost the game!'
    puts "The secret word was: #{@secret_word}"
    play_again
  end

  def play_again
    puts ''
    puts 'Would you like to play again?'
    puts '  Press (1) to play again.'
    puts '  Priss (2) to exit the game.'
    input = input_loop
    return new_game if input == '1'
    return exit if input == '2'
  end

  def new_game
    game = Hangman.new
    game.start
  end
end

game = Hangman.new
game.start
