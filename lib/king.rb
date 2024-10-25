require_relative 'chess_piece'

class King < ChessPiece
  attr_accessor :moved
  
  def initialize(color, position) 
    super(color, 'K', 'king', position)
    @moved = 0
  end
end