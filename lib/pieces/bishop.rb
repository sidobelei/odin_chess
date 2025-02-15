require_relative 'chess_piece'

class Bishop < ChessPiece
  def initialize(color, position)
    super(color, 'B', 'bishop', position)
  end

  def update_possible_moves(board)
    new_moves = []
    movement = [
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1]
    ] 
    movement.each do |move|
      if position == [nil, nil]
        break
      end
      
      temp = [
        position[0] + move[0], 
        position[1] + move[1]
      ]
      until out_of_bounds?(temp) || my_piece?(board, temp) || opponent_king?(board, temp)
        unless in_check?(board, temp)
          new_moves << temp
        end

        break if opponent_piece?(board, temp)
        temp = [
          temp[0] + move[0],
          temp[1] + move[1]
        ]
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