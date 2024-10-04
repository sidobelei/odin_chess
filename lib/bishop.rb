require_relative 'chess_piece'

class Bishop < ChessPiece
  def initialize(color, position)
    super(color, 'B', 'bishop', position)
  end

  def out_of_bounds?(pos)
    pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
  end
end