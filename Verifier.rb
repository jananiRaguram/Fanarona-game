require './Coordinate'
require './Board'

module Direction
  UP = [-1, 0]
  DOWN = [1, 0]
  LEFT = [0, -1]
  RIGHT = [0, 1]
  UP_LEFT = [-1, -1]
  UP_RIGHT = [-1, 1]
  DOWN_LEFT = [1, -1]
  DOWN_RIGHT = [1, 1]
end

class Verifier
  def initialize
    @board = Board.new
  end

  def get_captured_pieces(start_position, end_position, capture_type)
    captured_pieces = []
    # puts "start_position: #{start_position.x}, #{start_position.y}, end_position: #{end_position.x}, #{end_position.y}"
    piece_colour = @board.get_piece(start_position.x, start_position.y).colour

    x_direction = end_position.x - start_position.x
    y_direction = end_position.y - start_position.y

    if capture_type == 'Withdraw'
      piece = @board.get_piece(start_position.x - x_direction, start_position.y - y_direction)
      
      until piece.nil? || piece.colour == piece_colour
        captured_pieces.push(piece)
        piece = @board.get_piece(piece.coordinate.x - x_direction, piece.coordinate.y - y_direction)
      end
    elsif capture_type == 'Approach'
      piece = @board.get_piece(end_position.x + x_direction, end_position.y + y_direction)
      
      until piece.nil? || piece.colour == piece_colour
        captured_pieces.push(piece)
        piece = @board.get_piece(piece.coordinate.x + x_direction, piece.coordinate.y + y_direction)
      end
    end

    captured_pieces
  end

  def determine_move_outcome(start_position, end_position, piece_colour)
    return nil unless is_valid_move_position(start_position, end_position)

    x_direction = end_position.x - start_position.x
    y_direction = end_position.y - start_position.y

    withdraw_piece = @board.get_piece(start_position.x - x_direction, start_position.y - y_direction)
    withdraw_capture = true if !withdraw_piece.nil? && (withdraw_piece.colour != piece_colour)

    approach_piece = @board.get_piece(end_position.x + x_direction, end_position.y + y_direction)
    approach_capture = true if !approach_piece.nil? && (approach_piece.colour != piece_colour)

    # puts "w #{withdraw_capture} a #{approach_capture}"

    if withdraw_capture and approach_capture
      'Withdraw and Approach'
    elsif withdraw_capture
      'Withdraw'
    elsif approach_capture
      'Approach'
    else
      'Move'
    end
  end

  def calculate_valid_move_pieces(current_player_colour)
    valid_move_pieces = []
    capture_move_pieces = []

    @board.piece_array.each do |piece|
      move_positions = calculate_valid_move_positions(piece.coordinate)
      next unless move_positions.length > 0

      move_positions.each do |move_position|
        if piece.colour == current_player_colour
          move_outcome = determine_move_outcome(piece.coordinate, move_position, piece.colour)
          if move_outcome == nil or capture_move_pieces.last == piece
            break
          end
          
          if move_outcome != 'Move'
            capture_move_pieces.push(piece) 
          else
            valid_move_pieces.push(piece)
          end
        end
      end
    end

    if capture_move_pieces.length > 0
      capture_move_pieces
    else
      valid_move_pieces
    end
  end

  def calculate_valid_move_positions(piece_position)
    valid_move_positions = []
    # Iterate over all directions using the Direction enum
    Direction.constants.each do |direction|
      dx, dy = Direction.const_get(direction)
      next if dx != 0 and dy != 0 and piece_position.x % 2 != piece_position.y % 2

      new_x = piece_position.x + dx
      new_y = piece_position.y + dy

      if new_x >= 0 and new_x <= 8 and new_y >= 0 and new_y <= 4 and @board.get_piece(new_x, new_y).nil?
        valid_move_positions.push(Coordinate.new(new_x, new_y))
      end
    end

    valid_move_positions
  end

  def get_board_representation
    ascii_board = Array.new(11) { Array.new(18, '  ') }

    # top left of board is [0,0]
    black_circle = "\u{25CF}"
    white_circle = "\u{25CB}"
    vertical_line = "\u{02C8}"

    # Place the row labels (1-5)
    i = 0
    j = 1
    while i < 11
      if i.even?
        ascii_board[i][0] = ' '
      else
        ascii_board[i][0] = "#{6 - j}"
        j += 1
      end
      i += 1
    end

    ('A'..'I').each_with_index do |label, index|
      ascii_board[10][1 + index ] = " #{label}  "
    end

    # Place pieces on the board
    @board.piece_array.each do |piece|
      x = piece.coordinate.x
      y = piece.coordinate.y

      ascii_board[y * 2 + 1][x * 2 + 1] = piece.colour == Colour::BLACK ? ' ' + black_circle : ' ' + white_circle
    end

    # Add horizontal separators
    ascii_board.each_with_index do |row, row_index|
      if row_index != 10 and row_index != 0

        if row_index.even?
          # Add vertical separators on even rows
          (1..18).step(2) { |index| row[index] = ' |' }
        else
          # Add horizontal separators on odd rows
          (2..17).step(2) { |index| row[index] = ' -' }
        end
      end
    end

    #  Adding diagonal separators to the board
    i = 0
    while i < 11

      if [2, 6].include?(i)
        (2..17).step(4) do |j|
          ascii_board[i][j] = ' \\'
          ascii_board[i][j + 2] = ' /'
        end
      elsif [4, 8].include?(i)
        (4..17).step(4) do |j|
          ascii_board[i][j] = ' \\'
          ascii_board[i][j - 2] = ' /'
        end
      end

      i += 1
    end

    ascii_board
  end

  def is_valid_move_position(piece_position, move_position)
    if @board.get_piece(piece_position.x,
                        piece_position.y).nil? || @board.get_piece(move_position.x, move_position.y) != nil
      return false
    end

    x_direction = move_position.x - piece_position.x
    y_direction = move_position.y - piece_position.y

    return false if x_direction.abs > 1 || y_direction.abs > 1

    true
  end

  # added
  # added this from player manager, since that class doesn't have access to the pieces
  def pieces_on_board
    num_b = @board.num_black_pieces
    num_w = @board.num_white_pieces

    return true if num_b == 0 or num_w == 0
    false
  end

  def most_pieces_on_board
    num_b = @board.num_black_pieces
    num_w = @board.num_white_pieces

    if num_b > num_w
      return 'black'
    else 
      return 'white'
    end 
    
  end 
  
  def update_board(start_position, end_position, captured_pieces)
    if captured_pieces.length != 0
      @board.remove_pieces(captured_pieces) 
    end
    @board.move_piece(start_position, end_position)
  end

  def letter_rep(coord_x, coord_y)
    col_letter = ('A'.ord + coord_x).chr
    coord_y = 5 - coord_y

    x_y = []
    x_y.push(col_letter)
    x_y.push(coord_y)

    x_y
  end

  def number_rep(coordinate)
    letter, number = coordinate.split('')
    x_coord = letter.upcase.ord - 'A'.ord
    y_coord = 5 - number.to_i

    @board.board_coord(x_coord, y_coord)
  end

  def piece_exists(piece_coord)
     if @board.get_piece(piece_coord.x, piece_coord.y) != nil
       return true
     end 
    false
  end

  
end
