def random_word
  txt = 'google-10000-english-no-swears.txt'

  list = []
  file = File.open(txt)
  until file.eof?
    line = file.readline.strip
    if line.length >= 5 && line.length <= 12
      list.push(line)
    end
  end

  list.sample
end

puts random_word