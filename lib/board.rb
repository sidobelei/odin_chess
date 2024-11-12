require_relative 'king'
require_relative 'queen'
require_relative 'bishop'
require_relative 'knight'
require_relative 'rook'
require_relative 'pawn'

class Board
  def initialize
  end

  def initialize_board
    board = []
    setup = [
      {'color' => 'red', 'king_row' => 0, 'pawn_row' => 1},
      {'color' => 'white', 'king_row' => 7, 'pawn_row' => 6}
    ]

    setup.each do |set|    
      board << King.new(set['color'], [set['king_row'], 4])
      board << Queen.new(set['color'], [set['king_row'], 3])
      board << Bishop.new(set['color'], [set['king_row'], 2])
      board << Bishop.new(set['color'], [set['king_row'], 5])
      board << Knight.new(set['color'], [set['king_row'], 1])
      board << Knight.new(set['color'], [set['king_row'], 6])
      board << Rook.new(set['color'], [set['king_row'], 0])
      board << Rook.new(set['color'], [set['king_row'], 7])
      
      for i in 0..7 do
        board << Pawn.new(set['color'], [set['pawn_row'], i])
      end
    end
    return board
  end
end

