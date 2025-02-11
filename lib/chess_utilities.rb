module ChessUtilites
  def out_of_bounds?(pos)
    pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
  end

  def opponent_king?(board, pos)
    board.any? { |piece| piece.type == 'king' && piece.position == pos && piece. color != @color } 
  end

  def my_piece?(board, pos)
    board.any? { |piece| piece.color == @color && piece.position == pos }
  end 

  def opponent_piece?(board, pos)
    board.any? { |piece| piece.color != @color && piece.position == pos }
  end

  def in_check?(board, pos)
    temp_board = []
    board.each do |piece|
      if piece == self
        self_piece = piece.clone
        self_piece.position = pos
        temp_board << self_piece
      elsif piece.position == pos && piece.color != @color
        next
      else
        temp_board << piece.clone
      end
    end
  
    my_king = temp_board.find { |piece| piece.type == 'king' && piece.color == self.color }
    my_king_pos = my_king.position
    movement = [
      {'position' => [-1, -1], 'continuous' => true, 'direction' => 'diagonal', 'pieces' => ['queen', 'bishop']},
      {'position' => [-1, 0], 'continuous' => true, 'direction' => 'straight', 'pieces' => ['queen', 'rook']},
      {'position' => [-1, 1], 'continuous' => true, 'direction' => 'diagonal', 'pieces' =>['queen', 'bishop']},
      {'position' => [0, 1], 'continuous' => true, 'direction' => 'straight', 'pieces' => ['queen', 'rook']},
      {'position' => [1, 1], 'continuous' => true, 'direction' => 'diagonal', 'pieces' => ['queen', 'bishop']},
      {'position' => [1, 0], 'continuous' => true, 'direction' => 'straight', 'pieces' => ['queen', 'rook']},
      {'position' => [1, -1], 'continuous' => true, 'direction' => 'diagonal', 'pieces' => ['queen', 'bishop']},
      {'position' => [0, -1], 'continuous' => true, 'direction' => 'straight', 'pieces' => ['queen', 'rook']},
      {'position' => [-2, -1], 'continuous' => true, 'direction' => 'l-shape', 'pieces' => ['knight']},
      {'position' => [-2, 1], 'continuous' => true, 'direction' => 'l-shape', 'pieces' => ['knight']},
      {'position' => [-1, 2], 'continuous' => true, 'direction' => 'l-shape', 'pieces' => ['knight']},
      {'position' => [1, 2], 'continuous' => false, 'direction' => 'l-shape', 'pieces' => ['knight']},
      {'position' => [2, 1], 'continuous' => false, 'direction' => 'l-shape', 'pieces' => ['knight']},
      {'position' => [2, -1], 'continuous' => false, 'direction' => 'l-shape', 'pieces' => ['knight']},
      {'position' => [1, -2], 'continuous' => false, 'direction' => 'l-shape', 'pieces' =>['knight']},
      {'position' => [-1, -2], 'continuous' => false, 'direction' => 'l-shape', 'pieces' => ['knight']}
    ]
    movement.each do |move|
      temp = [my_king_pos[0] + move['position'][0], my_king_pos[1] + move['position'][1]]
      squares = 1
      if move['continuous'] == true
        until out_of_bounds?(temp) || my_piece?(temp_board, temp)
          if squares == 1 && temp_board.any? { |piece| piece.position == temp && piece.type == 'pawn' && piece.color != @color } && (move['position'] == [-1, -1] || move['position'] == [-1, 1]) && my_king.color == 'white'
            return true
          elsif squares == 1 && temp_board.any? { |piece| piece.position == temp && piece.type == 'pawn' && piece.color != @color } && (move['position'] == [1, -1] || move['position'] == [1, 1]) && my_king.color == 'red'
            return true
          elsif squares == 1 && temp_board.any? { |piece| piece.position == temp && piece.type == 'king' && piece.color != @color } && (move['direction'] == 'diagonal' || move['direction'] == 'straight')
            return true
          elsif temp_board.any?{ |piece| piece.position == temp && move['pieces'].include?(piece.type) && piece.color != @color }
            return true
          elsif opponent_piece?(temp_board, temp)
            break
          else
            temp = [temp[0] + move['position'][0], temp[1] + move['position'][1]]
            squares += 1
          end
        end
      else
        if temp_board.any?{ |piece| piece.position == temp && move['pieces'].include?(piece.type) && piece.color != @color }
          return true
        end  
      end
    end
    return false
  end
end