require './HomeScreen'
require './GameScreen'

class App
  
  def run
    @homeScreen = HomeScreen.new

    @homeScreen.print_fanarona_header # prints "FANARONA" in blocks

    player_one_colour = @homeScreen.select_player_colour
    
    continue_play = @homeScreen.start_game #ask to start game before setting everything up

    @game_screen = GameScreen.new(player_one_colour)

    while continue_play == true # per game loop

      @homeScreen.print_fanarona_header # OPTIONAL CAN BE REMOVED
      @game_screen.show_player_colour
      
      @game_screen.display_ascii # draw the current board
      @game_screen.display_player_turn # display whose turn it is
      @game_screen.display_moveable_pieces # display what pieces they can move
      choose_other_piece = true
      while choose_other_piece == true
        chosen_piece = @game_screen.select_piece
        next if chosen_piece.nil?

        @game_screen.display_legal_moves(chosen_piece)
        choose_other_piece = @game_screen.choose_piece_destination(chosen_piece)
      end
     
      # swap player_turn
      @game_screen.end_player_turn

      # see if move ended game
      if @game_screen.end_game == true
        if @game_screen.choose_play_again == true
          @game_screen.display_reset
        else
          continue_play = false
        end
      end
    end

  end

  
end

a = App.new
a.run
