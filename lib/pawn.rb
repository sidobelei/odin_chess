require_relative 'chess_piece'

class Pawn < ChessPiece
attr_accessor :moved, :promoted, :opposite_row, :direction, :en_passant_moves

  def initialize(color, position)
    super(color, 'P', 'pawn', position)
    @moved = 0
    @promoted = false
    if color == 'red'
      @opposite_row = 7
      @direction = 1
    elsif color == 'white'
      @opposite_row = 0
      @direction = -1
    end
    @en_passant_moves = []
  end

  def update_position(new_position)
    if new_position[0] == opposite_row
      @position = nil
      @promoted = true
    else
      @position = new_position
    end
    @moved += 1
  end

  def update_possible_moves(board)
    new_moves = []
    movement = [
      [direction, -1, 'attack'],
      [direction, 0, 'movement'],
      [direction, 1, 'attack'],
    ]
    movement.each_with_index do |move, index|
      temp = [
        position[0] + move[0], 
        position[1] + move[1]
      ]
      if opponent_piece?(board, temp) && move[2] == 'attack'
        new_moves << temp
      elsif out_of_bounds?(temp) == false && king_or_same_color?(board, temp) == false && opponent_piece?(board, temp) == false && move[2] == 'movement'
        new_moves << temp
        temp = [temp[0] + direction, temp[1]]
        if moved == 0 && opponent_piece?(board, temp) == false && king_or_same_color?(board, temp) == false
          new_moves << temp
        end
      else
        next 
      end
      @possible_moves = new_moves
    end 
  end

  def remove_en_passant
    removed_move = en_passant_moves.shift
    possible_moves.delete(removed_move)
  end
end