require './Game'

class GameScreen < UI
  def initialize(player_colour)
    @game = Game.new(player_colour)
  end

  # Changed
  def select_piece
    piece_coord = nil

    print 'Choose a piece to move: '
    input = get_player_input
    piece_coord = @game.verifier.number_rep(input)
    valid_pieces = list_moveable_pieces

    valid_position = false
    for piece in valid_pieces
      if piece_coord.x == piece.coordinate.x and piece_coord.y == piece.coordinate.y
        valid_position = true
        break
      end
    end

    if valid_position == false
      puts 'Invalid selection, please try again'
      piece_coord = nil
    end

    piece_coord
  end

  def choose_piece_destination(piece_coord)
    good_input = false
    while good_input == false
      print 'Choose Move or type "cancel" to choose a different piece: '
      input = get_player_input.downcase

      if input == 'cancel'
        good_input = true
      elsif input[0] >= 'a' and input[0] <= 'i' and input[1].to_i >= 1 and input[1].to_i <= 5
        good_input = false
        piece_pos = @game.verifier.number_rep(input)

        valid_positions = @game.verifier.calculate_valid_move_positions(piece_coord)
        for pos in valid_positions
          good_input = true if pos.x == piece_pos.x and pos.y == piece_pos.y
        end
      end

      puts 'Invalid selection, please try again' if good_input == false
    end

    # check input is properly formatted as a coordinate cpatial letter then number
    if input != 'cancel'
      piece_destination = @game.verifier.number_rep(input)

      # puts "Game Screen 29 - piece_destination = #{piece_destination.x}, #{piece_destination.y}"
      capture_input_good = false
      while capture_input_good == false
        capture_type = @game.do_player_turn(piece_coord, piece_destination)
        # puts "cap type #{capture_type}"
        if capture_type == 'Withdraw and Approach'
          chosen_type = display_capture_type # gets chosen_type
          if chosen_type == 'W'
            capture_input_good = true
            capture_type = 'Withdraw'
          elsif chosen_type == 'A'
            capture_input_good = true
            capture_type = 'Approach'
          else
            puts "sorry I didn't quite catch that."
          end
        else
          capture_input_good = true
        end
      end

      captured_pieces = @game.verifier.get_captured_pieces(piece_coord, piece_destination, capture_type)
      @game.verifier.update_board(piece_coord, piece_destination, captured_pieces)
      return false
    end

    true
  end

  def display_capture_type
    print 'Perform an approach(A) or withdraw(W) capture? '
    input = get_player_input.upcase
  end

  def display_ascii
    board_ascii = @game.verifier.get_board_representation

    board_ascii.each do |row|
      puts row.join('')
    end
  end

  def display_moveable_pieces
    pieces = list_moveable_pieces
    print 'Moveable pieces: '

    pieces.each_with_index do |piece, index|
      coord = @game.verifier.letter_rep(piece.coordinate.x, piece.coordinate.y)
      print "#{coord[0]}#{coord[1]}"
      print ', ' unless index == pieces.length - 1
    end
    puts "\n"
  end

  def list_moveable_pieces
    current_player = @game.manager.player_turn
    @game.verifier.calculate_valid_move_pieces(current_player.colour)
  end

  def display_player_turn
    current_player = @game.manager.player_turn
    colour = if current_player.colour == :w
               'WHITE'
             else
               'BLACK'
             end

    puts '===================='
    puts "  BEGIN #{colour} TURN  "
    puts '===================='
  end

  def display_legal_moves(chosen_piece)
    print 'Valid Moves: '
    valid_positions = @game.verifier.calculate_valid_move_positions(chosen_piece)
    valid_positions.each_with_index do |pos, index|
      coord = @game.verifier.letter_rep(pos.x, pos.y)

      print "#{coord[0]}#{coord[1]}"
      print ', ' unless index == valid_positions.length - 1
    end
    puts "\n"
  end

  # added
  def end_game
    if @game.end_game == true
      puts 'Game over'
      display_winner
      return true
    end
    false
  end

  def choose_play_again
    valid_input = false

    while valid_input == false
      puts 'Do you want to play again? (Y/N)'
      input = get_player_input.downcase

      if input != 'y' and input != 'n'
        puts 'invalid input, try again'
      elsif input == 'y'
        return true
      else
        return false
      end
    end
  end

  def end_player_turn
    current_player = @game.manager.player_turn
    colour = if current_player.colour == :w
               'WHITE'
             else
               'BLACK'
             end

    puts '===================='
    puts "  END #{colour} TURN  "
    puts '===================='
    @game.end_player_turn
  end

  def display_reset
    puts 'Game Reset'
    @game.reset_game
  end

  def show_player_colour
    black_circle = "\u{25CF}"
    white_circle = "\u{25CB}"
    if @game.manager.player_one.colour == :w
      puts "   P1 (white pieces): #{white_circle}   P2 (black pieces) #{black_circle}"
    else 
      puts "   P2 (white pieces): #{white_circle}   P1 (black pieces) #{black_circle}"
    end
  end

  private

  def display_winner
    winner = @game.game_winner
    puts "Player #{winner} wins!"
  end
end
