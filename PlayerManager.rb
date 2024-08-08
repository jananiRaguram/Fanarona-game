require './Player'

# enum for player colour
module Colour
  WHITE = :w
  BLACK = :b
end

class PlayerManager
  attr_accessor :player_one, :player_two, :player_turn

  # what is player turn (Player object or colour), doens't make sense to set player turn when the player is being created

  def initialize(player_colour)
    @player_one = Player.new
    @player_two = Player.new

    # set the player who chooses white to player one
    # 1 is set to colour white
    if player_colour == 1
      @player_turn = @player_one
      @player_one.colour = Colour::WHITE
      @player_two.colour = Colour::BLACK
    else
      @player_turn = @player_two
      @player_one.colour = Colour::BLACK
      @player_two.colour = Colour::WHITE
    end
  end

  def end_turn
    if @player_turn == @player_one
      @player_turn = @player_two
     else
      @player_turn = @player_one
     end
  end

end
