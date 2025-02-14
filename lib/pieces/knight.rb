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

      unless out_of_bounds?(temp) || my_piece?(board, temp) || in_check?(board, temp) || opponent_king?(board, temp)  
        new_moves << temp
      end
    end
    @possible_moves = new_moves
  end

  def to_json(*args)
    {
      'color' => @color,
      'type' => @type,
      'position' => @position
    }.to_json
  end
end