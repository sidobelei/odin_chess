require_relative 'chess_piece'

class Pawn < ChessPiece
attr_accessor :moved, :promoted, :opposite_row

  def initialize(color, position)
    super(color, 'P', 'pawn', position)
    @moved = false
    @promoted = false
    if color == 'red'
      @opposite_row = 7
    elsif color == 'white'
      @opposite_row = 0
    end
    
  end

  def update_position(new_position)
    if moved == false
      @moved = true
    end
    
    if new_position[0] == opposite_row
      @position = nil
      @promoted = true
    else
      @position = new_position
    end
  end
end