require_relative 'chess_piece'

class Bishop < ChessPiece
  def initialize(color, position)
    super(color, 'B', 'bishop', position)
  end
end