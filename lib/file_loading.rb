module FileLoading
  def load
    puts Dir.chdir('./saved_games')
    puts Dir.pwd
    # if !Dir.exist?('./saved_games')
    #   loop do
    #     puts 'No saved games.'
    #     break if user_input == '1'
    #   end
    # else
    #   loaded_game = File.open("/saved_games/#{loaded_file_name}.yml", 'r') do |file|
    #     YAML.load(file)
    #   end
    #   loaded_game.play
    # end
  end

  def loaded_file_name
    saved_games = Dir.glob('saved_game/').map { |game| game.split('/').last.split('.yml').first }
    file_count = saved_games.size
    puts file_count
    # loop do
    #   puts 'Enter a number of a game to load.'
    #   saved_games.each_with_index { |game, i| puts "#{i + 1}: #{game}" }
    #   file_num = gets.chomp.strip
    #   if /\A[1-9]+\Z/.match?(file_num) && file_num.to_i <= file_count
    #     return saved_games[file_num.to_i - 1]
    #   end
    #   puts 'Invalid input.'
    # end
  end
end

