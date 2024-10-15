require_relative 'chess_piece'

class Pawn < ChessPiece
attr_accessor :moved, :promoted

  def initialize(color, position)
    super(color, 'P', 'pawn', position)
    @moved = false
    @promoted = false
  end
end