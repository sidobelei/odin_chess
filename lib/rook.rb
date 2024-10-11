require_relative 'chess_piece'

class Rook < ChessPiece
  attr_accessor :moved

  def initialize(color, position) 
    super(color, 'R', 'rook', position)
    @moved = false
  end
end