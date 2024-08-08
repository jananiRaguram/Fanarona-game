class Board
    attr_accessor :piece_array

    def initialize(piece_array)
        @piece_array = piece_array
    end

    def move_piece(current_position, end_position)
        @piece_array.each do |piece|
            if piece.coordinate == current_position
                piece.coordinate = end_position
                break
            end
        end

        # OR

        # for i in @piece_array do
            # if @piece_array[i].coordinate.x == current_position.x and @piece_array[i].coordinate.y == current_position.y
            #     @piece_array[i].coordinate = end_position
            # end
        # end
    end

    def remove_pieces(pieces_to_remove)
        @piece_array = @piece_array - pieces_to_remove

        # OR

        # pieces_to_remove.each do |remove_piece|
        #     @piece_array.each_with_index do |piece, index|
        #         if remove_piece.coordinate == piece.coordinate
        #             @piece_array.delete_at(index)
        #         end
        #     end
        # end
    end

    def get_piece(x, y)
        @piece_array.each do |piece|
            if piece.coordinate.x == x and piece.coordinate.y == y
                return piece
            end
        end
    end

end