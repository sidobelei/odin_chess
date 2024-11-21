module ChessUtilites
  def out_of_bounds?(pos)
    pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
  end

  def in_check?(board, pos)
    temp_board = []
    board.each do |piece|
      if piece == self
        self_piece = piece.clone
        self_piece.position = pos
        temp_board << self_piece
      else
        temp_board << piece.clone
      end
    end
    
    my_king = temp_board.find { |piece| piece.type == 'king' && piece.color == self.color }
    temp_board.each do |piece|
      piece.possible_moves.each do |move|
        if move == my_king.position && piece.color != my_king.color
          return true
        end
      end
    end
    return false
  end
end