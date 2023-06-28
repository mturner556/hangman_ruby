module FileLoading
  def load
    file_name = loaded_file_name
    File.open("./saved_games/#{file_name}.yml") do |f|
      game = YAML::load(f, permitted_classes: [Hangman])
      game.play
    end
  end

  def loaded_file_name
    puts 'Please enter the name of the file you would like to play.'
    saved_games
    gets.chomp.downcase.strip
  end

  def saved_games
    puts 'Saved games:'
    puts Dir['./saved_games/*'].map { |f| f.split('/')[-1].split('.')[0] }
  end
end

