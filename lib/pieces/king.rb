require_relative 'chess_piece'

class King < ChessPiece
  attr_accessor :moved, :check_status

  def initialize(color, position) 
    super(color, 'K', 'king', position)
    @moved = 0
    @check_status = false
  end

  def update_position(new_position) 
    if new_position == ['0-0-0']
      @position = [position[0], 2]
    elsif new_position == ['0-0']
      @position = [position[0], 6]
    else
      @position = new_position
    end
    @moved += 1
  end

  def update_possible_moves(board)
    new_moves = []
    movement = [
      [-1, -1],
      [-1, 0],
      [-1, 1],
      [0, 1],
      [1, 1],
      [1, 0],
      [1, -1],
      [0, -1]
    ]
    movement.each do |move|
      if position == [nil, nil]
        break
      end
      
      temp = [position[0] + move[0], position[1] + move[1]]
      unless in_check?(board, temp) || out_of_bounds?(temp) || my_piece?(board, temp)
        new_moves << temp
      end
    end
    @possible_moves = new_moves
    add_castling(board) 
    if in_check?(board, @position)
      @check_status = true
    else
      @check_status = false
    end
  end
  
  def add_castling(board)
    remove_castling
    if moved == 0 && in_check?(board, @position) == false
      directions = [-1, 1]
      directions.each do |direction|
        space = 1
        while space < 5
          temp = [position[0], position[1] + (direction * space)]
          if space == 4 && direction == -1 && board.any? {|piece| piece.type == 'rook' && piece.color == color && piece.moved == 0 && piece.position == temp}
            @possible_moves << ['0-0-0']
          elsif space == 3 && direction == 1 && board.any? {|piece| piece.type == 'rook' && piece.color == color && piece.moved == 0 && piece.position == temp}
            @possible_moves << ['0-0']
          else
            break if board.any? {|piece| piece.position == temp} || in_check?(board, temp) == true          
          end
          space += 1
        end
      end
    end
  end

  def remove_castling
    @possible_moves.delete(['0-0'])
    @possible_moves.delete(['0-0-0'])
  end

  def to_json(*args)
    {
      'color' => @color,
      'position' => @position,
      'type' => @type,
      'moved' => @moved,
      'check_status' => @check_status
    }.to_json
  end

  def from_json(args)
    self.instance_variable_set("@moved", args['moved'])
    self.instance_variable_set("@check_status", args['check_status'])
  end
end