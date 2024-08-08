require "./Piece.rb"
require "./Coordinate.rb"


class Board
    attr_accessor :piece_array

    def initialize()
        @piece_array = get_black_pieces() + get_white_pieces() 
    end

    def move_piece(current_position, end_position)
        @piece_array.each do |piece|
            if piece.coordinate.x == current_position.x && piece.coordinate.y == current_position.y
                piece.coordinate.x = end_position.x
                piece.coordinate.y = end_position.y
                break
            end
        end
    end

    def remove_pieces(pieces_to_remove)
        @piece_array = @piece_array - pieces_to_remove
    end

    def get_piece(x, y)
        @piece_array.each do |piece|
            if piece.coordinate.x == x && piece.coordinate.y == y
                return piece
            end
        end
        
        return nil
    end


    def num_black_pieces()
        num = 0
        for piece in @piece_array
            if piece.colour == :b
                num += 1 
            end 
        end 
        
        num
    end 

    def num_white_pieces()
        num = 0
        for piece in @piece_array
            if piece.colour == :w
                num += 1 
            end 
        end 
        
        num
    end 

    def board_coord(x, y)
        Coordinate.new(x, y)
    end 

    private
    def get_black_pieces()
        pieces = []
        for i in 0..2 do
            for j in 0..8 do
                if(i == 2 && (j == 1 || j == 3 || j == 4 || j == 6 || j == 8))
                    next
                end
                coordinate = Coordinate.new(j, i)
                piece = Piece.new(Colour::BLACK, coordinate)
                pieces.push(piece)
            end
        end
        return pieces
    end

    def get_white_pieces()
        pieces = []
        for i in 2..4 do
            for j in 0..8 do
                if(i == 2 && (j == 0 || j == 2 || j == 4 || j == 5 || j == 7))
                    next
                end
                coordinate = Coordinate.new(j, i)
                piece = Piece.new(Colour::WHITE, coordinate)
                pieces.push(piece)
            end
        end
        return pieces
    end
 
end


