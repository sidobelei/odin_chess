require_relative 'chess_piece'

class Knight < ChessPiece
  def initialize(color, position)
    super(color, 'N', 'knight', position)
  end  
end