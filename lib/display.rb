module Display
  def start_instructions
    instructions = "To play Hangman:
    Press (1) to start a new game.
    Press (2) to load a previous game."
    puts instructions
  end

  def error
    puts "Error. Let's try that again."
  end
end