require_relative 'chess_piece'

class Rook < ChessPiece
  attr_accessor :moved

  def initialize(color, position) 
    super(color, 'R', 'rook', position)
    @moved = 0
  end

  def update_position(new_position)
    @position = new_position
    @moved += 1
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
      'position' => @position,
      'moved' => @moved
    }.to_json
  end

  def from_json(args)
    self.instance_variable_set("@moved", args['moved'])
  end
end