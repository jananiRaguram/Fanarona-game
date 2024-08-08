class Game
    attr_accessor :verifier, :manager

    def initialize
        @verifier = Verifier.new()
        @manager = PlayerManager.new(Player.new)
    end
    # Calls determine_move_outcome to determine the move's outcome
    def do_player_turn(piece, piece_destination)
        verifier.determine_move_outcome(piece, piece_destination)
    end
    # Ends the current player's turn.
    def end_player_turn()
        manager.end_turn()
    end
    # Ends the game
    def end_game()
        puts "The game had ended!"
    end
    # Resets the game
    def reset_game()
        @verifier = Verifier.new()
        @manager = PlayerManager.new(Player.new)
        puts "The game has been reset!"
    end
end
