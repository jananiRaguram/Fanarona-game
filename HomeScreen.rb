require './UI'

class HomeScreen < UI # HomeScreen inherits UI
  
  def select_player_colour # returns string
    player_1_colour = nil

    while player_1_colour != 1 and player_1_colour != 2
      puts 'Enter 0 to view instructions.'
      print 'Press 1 to play as white pieces, or 2 to play as black pieces. '
      player_1_colour = get_player_input
      player_1_colour = player_1_colour.chomp.to_i

      if player_1_colour != 1 and player_1_colour != 2
        if player_1_colour == 0
          display_instructions
          print_fanarona_header
        else
          puts "Sorry I didn't quite catch that. Please try again."
        end
      end

    end

    player_1_colour
  end

  def start_game # provides the user with the option to start the game
    start_game = 0

    while start_game != 'y' and start_game != 'n'
      print 'Start game [y/n]: '
      start_game = get_player_input
      start_game = start_game.downcase # convert to lowercase
    end

    if start_game == 'n'
      false
    end
    
    true
  end
  
end
