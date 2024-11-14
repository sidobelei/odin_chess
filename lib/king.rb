require_relative 'chess_piece'

class King < ChessPiece
  attr_accessor :moved

  def initialize(color, position) 
    super(color, 'K', 'king', position)
    @moved = 0
  end

  def update_position(new_position) 
    if new_position == ['0-0-0']
      @position = [position[0], 2]
      return [position[0], 3]
    elsif new_position == ['0-0']
      @position = [position[0], 6]
      return [position[0], 5]
    end
    @position = new_position
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
      temp = [position[0] + move[0], position[1] + move[1]]
      unless in_check?(board, temp) || opponent_piece?(board, temp) || king_or_same_color?(board, temp) || out_of_bounds?(temp)
        new_moves << temp
      end
    end
    @possible_moves = new_moves
    add_castling(board) 
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
end