require './Verifier'
require './PlayerManager'

class Game
  attr_reader :verifier, :manager

  def initialize(player_colour)
    @verifier = Verifier.new
    @manager = PlayerManager.new(player_colour)
  end

  # Calls determine_move_outcome to determine the move's outcome
  def do_player_turn(piece_start, piece_destination)
    @verifier.determine_move_outcome(piece_start, piece_destination, @manager.player_turn.colour)
  end

  # Ends the current player's turn.
  # Use when no more captures or player chooses to end the turn
  def end_player_turn
    @manager.end_turn
  end

  # added
  # Ends the game
  def end_game
    @verifier.pieces_on_board
  end

  def game_winner
    most_on_board = @verifier.most_pieces_on_board
    
    if most_on_board == 'white'
      if @manager.player_one.colour == :w
        return 1
      else
        return 2
      end
    else
      if @manager.player_one.colour == :b
        return 1
      else
        return 2
      end
    end
  end

  # Resets the game
  def reset_game
    @verifier = Verifier.new
    if @manager.player_one.colour == :w
      @manager = PlayerManager.new(2)
    else 
      @manager = PlayerManager.new(1)
    end 
  end
end
