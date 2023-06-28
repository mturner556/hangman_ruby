
module FileSaving
  def save
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    fname = save_file_name
    File.open("./saved_games/#{fname}.yml", 'w') do |f|
      f.write(YAML.dump(self))
    end
    puts 'Game saved.'
    exit
  end

  def save_file_name
    saved_games = Dir.glob('saved_games/*')
    loop do
      puts 'Enter a name to save your game.'
      name = gets.chomp.downcase.strip
      if saved_games.include?("saved_games/#{name}.yml")
        puts 'File already exists. Enter a different name.'
        next
      end
      return name unless /\s+|^$/.match?(name)
    end
  end
end
