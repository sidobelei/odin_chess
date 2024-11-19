require_relative 'chess_piece'

class Knight < ChessPiece
  def initialize(color, position)
    super(color, 'N', 'knight', position)
  end
  
  def update_possible_moves(board)
    new_moves = []
    movement = [
      [-2, -1],
      [-2, 1],
      [-1, 2],
      [1, 2],
      [2, 1],
      [2, -1],
      [1, -2],
      [-1, -2]
    ]
    movement.each do |move|
      if position == [nil, nil]
        break
      end
      
      temp = [
        position[0] + move[0], 
        position[1] + move[1]
      ]
      unless out_of_bounds?(temp) || king_or_same_color?(board, temp)
        new_moves << temp
      end
    end
    @possible_moves = new_moves
  end
end