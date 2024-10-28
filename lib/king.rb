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

  def in_check?(board, pos)
    board.each do |piece|
      piece.possible_moves.each do |move|
        if move == pos
          return true 
        end
      end
    end
    return false
  end
end