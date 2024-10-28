require_relative 'chess_piece'

class King < ChessPiece
  attr_accessor :moved

  def initialize(color, position) 
    super(color, 'K', 'king', position)
    @moved = 0
  end

  def update_position(new_position) 
    @position = new_position
    @moved += 1
  end
end