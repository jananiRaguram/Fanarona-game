class PlayerManager
    attr_accessor :players, :player_turn
    
    def initialize(player_turn)
        @players = []
        @player_turn = player_turn
    end
    
    def check_end_game
        # Implement this method to determine if a player has no pieces remaining and return a boolean value
    end
    
    def end_turn
        check_end_game
        set_player_turn unless check_end_game
    end
    
    def get_player_turn
        @player_turn
    end
    
    def set_player_turn(player_turn)
        @player_turn = player_turn
    end
end