class Player
  attr_accessor :color, :my_pieces, :inputs

  def initialize(color, pieces)
    @color = color
    @my_pieces = pieces
    @inputs = []
  end

  def valid_move?(pos, new_pos)  
    my_pieces.each do |piece|
      if piece.position == pos
        piece.possible_moves.each do |move|
          if new_pos == move
            return true
          end 
        end
      end
    end
    return false
  end
end