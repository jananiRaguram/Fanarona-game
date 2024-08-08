require_relative 'Coordinate.rb'

class Piece
    attr_accessor :colour, :coordinate

    def initialize(colour, coordinate)
        @colour = colour
        @coordinate = coordinate
    end

end
