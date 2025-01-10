require 'json'

module FileHandler
  SAVE_DIRECTORY = "./saved_games/"
  
  def create_save(game)
    unless Dir.exist?(SAVE_DIRECTORY)
      Dir.mkdir SAVE_DIRECTORY
    end

    file_name = nil
    puts "\n"
    until file_name
      puts "Please type in your file name and include the \".json\" extension:"
      input = gets.chomp
      unless input.include?(".json")
        puts "\nInvalid file name, try again.\n"
        next
      end
      input = SAVE_DIRECTORY + input
      if File.exist?(input)
        puts 'Would you like to overwrite your save?'
        answer = gets.chomp.downcase
        if answer == 'yes' || answer == 'y'
          File.delete(input)
        else
          next
        end
      end
      file_name = input  
    end
    File.open(file_name, "w") do |file|
      file.write(game.to_json)
    end
  end

  def get_save(game_file)
    string = File.read(game_file)
    save_file = JSON.parse(string)
    return save_file
  end
end