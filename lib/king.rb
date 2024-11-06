require_relative 'chess_piece'

class King < ChessPiece
  attr_accessor :moved, :castling

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
        if piece == self
          next
        end

        if move == pos && piece.color != @color
          return true 
        end
      end
    end
    return false
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
            @possible_moves << '[0-0-0]'
          elsif space == 3 && direction == 1 && board.any? {|piece| piece.type == 'rook' && piece.color == color && piece.moved == 0 && piece.position == temp}
            @possible_moves << '[0-0]'
          else
            break if board.any? {|piece| piece.position == temp} || in_check?(board, temp) == true          
          end
          space += 1
        end
      end
    end
  end

  def remove_castling
    @possible_moves.delete("[0-0]")
    @possible_moves.delete("[0-0-0]")
  end
end