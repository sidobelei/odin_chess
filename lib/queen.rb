require_relative 'chess_piece'

class Queen < ChessPiece
  def initialize(color, position)
    super(color, 'Q', 'queen', position)
  end
end