require './Game.rb'

class GameScreen

    def initialize 
        @game = Game.new
    end

    def select_piece()
        puts "Select a piece to move: "
    end

    def choose_piece_destination()
        puts "Choose the destination of the piece: "
    end
    
    # todo is this only printed when the capture type is more than 1, where is this info stored
    def display_capture_type()

        # @game.condition
        if condition is approach
            puts "Perform an approach: "
        elsif condition is withdraw
            puts "Perform an withdraw: "
        else
            puts "Perform an approach(A) or withdraw(W): "
        end
    end

    def display_ascii(board_ascii)
        puts board_ascii
    end

    
    def display_moveable_piece()
        puts"Moveable pieces: "
        # pieces = game.movable_pieces
        i = 0
        for piece in pieces
            puts "#{piece}" 
            if i < pieces.length()
                puts ", "
            end
            i += 1
        end
    end

    #colour might be enum 
    # todo how do I know who wins?
    def display_winner(colour)
        puts "Player #{colour} wins!"
    end

    def display_legal_moves()
        
    end
    
    def exit()
        puts "Game exiting"
    end

end

