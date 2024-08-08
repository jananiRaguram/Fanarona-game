require_relative 'Coordinate'
class Piece
    attr_accessor :colour, :coordinate

    def initialize(colour, x, y)
        @colour = colour
        @coordinate = Coordinate.new(x, y)
    end

    def get_colour
        @colour
    end

    def set_colour(colour)
        @colour = colour
    end

    def get_coordinate
        @coordinate
    end

    def set_coordinate(coordinate)
        @coordinate = coordinate
    end

end