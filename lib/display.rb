module Display
  def display
    puts "Save game by typing 'save'"
    puts "#{@key}"
    puts "------------"
    puts "#{@guesses.join}"
  end
end