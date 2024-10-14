require_relative 'chess_piece'

class Rook < ChessPiece
  attr_accessor :moved

  def initialize(color, position) 
    super(color, 'R', 'rook', position)
    @moved = false
  end

  def update_position(new_position)
    @position = new_position
    if moved == false
      @moved = true
    end
  end

  def update_possible_moves(board)
    new_moves = []
    movement = [
      [-1, 0],
      [0, 1],
      [1, 0],
      [0, -1]
    ] 
    movement.each do |move|
      temp = [
        position[0] + move[0], 
        position[1] + move[1]
      ]
      until out_of_bounds?(temp) || king_or_same_color?(board, temp)
        new_moves << temp
        break if opponent_piece?(board, temp)
        temp = [
          temp[0] + move[0],
          temp[1] + move[1]
        ]
      end
    end
    @possible_moves = new_moves
  end
end