class Player
    attr_accessor :colour
  
    def initialize
        @colour = nil
    end
  
    def set_colour(colour)
        @colour = colour
    end
  
    def get_colour
        @colour
    end
    
    private
    def get_captured_pieces(start_position, end_position)
        # Implement this method to return the positions of captured pieces as an array of coordinates
    end
end
  