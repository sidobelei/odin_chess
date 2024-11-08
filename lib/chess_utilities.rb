module ChessUtilites
  def out_of_bounds?(pos)
    pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
  end

  def in_check?(board, pos)
    board.each do |piece|
      if piece == self
        next
      end
      piece.possible_moves.each do |move|
        if move == pos && piece.color != @color
          return true 
        end
      end
    end
    return false
  end
end