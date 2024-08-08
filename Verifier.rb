require_relative 'Coordinate'

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
  def initialize()
    @board = Board.new()
  end

  def get_captured_pieces(start_position, end_position, capture_type)
    captured_pieces = []

    x_direction = start_position.x - end_position.x
    y_direction = start_position.y - end_position.y

    if capture_type == "Withdraw"
      x_direction *= -1
      y_direction *= -1
      piece = board.get_piece(start_position.x + x_direction, start_position.y + y_direction) != nil
    elsif capture_type == "Approach"
      piece = board.get_piece(end_position.x + x_direction, end_position.y + y_direction) != nil
    end

    while piece != nil
      captured_pieces.push(piece)
      piece = board.get_piece(piece.coordinate.x + x_direction, piece.coordinate.y + y_direction)
    end

    return captured_pieces
  end

  def determine_move_outcome(start_position, end_position)
    if !is_valid_move_position(start_position, end_position)
      return nil
    end

    x_direction = start_position.x - end_position.x
    y_direction = start_position.y - end_position.y

    if board.get_piece(end_position.x + x_direction, end_position.y + y_direction) != nil
      withdraw_capture = true
    end
    if board.get_piece(start_position.x - x_direction, start_position.y - y_direction) != nil
      approach_capture = true
    end

    if withdraw_capture and approach_capture
      return "Withdraw and Approach"
    elsif withdraw_capture
      return "Withdraw"
    elsif approach_capture
      return "Approach"
    else
      return "Move"
    end
  end

  def calculate_valid_move_pieces()
    valid_move_pieces = []
    capture_move_pieces = []

    board.piece_array.each do |piece|
      move_positions = calculate_valid_move_positions(piece.coordinate)
      if move_positions.length > 0
        move_positions.each do |move_position|
          if determine_move_outcome(piece.coordinate, move_position) != "Move"
            capture_move_pieces.push(piece)
          else
            valid_move_pieces.push(piece)
          end
        end
      end
    end

    if capture_move_pieces.length > 0
      return capture_move_pieces
    else
      return valid_move_pieces
    end
  end

  def calculate_valid_move_positions(piece_position)
    valid_move_positions = []

    # Iterate over all directions using the Direction enum
    Direction.constants.each do |direction|
      dx, dy = Direction.const_get(direction)
      new_x = piece_position.x + dx
      new_y = piece_position.y + dy

      if board.get_piece(new_x, new_y) == nil
        valid_move_positions.push(Coordinate.new(new_x, new_y))
      end
    end

    return valid_move_positions
  end

  def get_board_representation()
    return board.piece_array
  end

  def is_valid_move_position(piece_position, move_position)
    if board.get_piece(piece_position.x, piece_position.y) == nil || board.get_piece(move_position.x, move_position.y) != nil
      return false
    end

    x_direction = piece_position.x - move_position.x
    y_direction = piece_position.y - move_position.y

    if x_direction.abs > 1 || y_direction.abs > 1
      return false
    end

    return true
  end
end
