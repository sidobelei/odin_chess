require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'
require_relative 'pieces/rook'
require_relative 'pieces/pawn'

class Board
  attr_accessor :display

  def initialize
    @display = initialize_board 
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

  def update_pieces
    display.each do |piece|
      piece.update_possible_moves(@display)
    end
  end

  def to_s
    board_string = "   +---+---+---+---+---+---+---+---+\n"
    row = 0
    for i in (8).downto(1)
      board_string = board_string + "#{i}  |"
      for j in (0..7)
        if display.any?{ |piece| piece.position == [row, j] }
          square = display.find_index { |piece| piece.position == [row, j] }
          piece = display[square].name 
          board_string = board_string + " #{piece} |"
        else
          board_string = board_string + "   |"
        end
      end
      board_string = board_string + "\n   +---+---+---+---+---+---+---+---+\n"
      row += 1
    end
    board_string = board_string + "     a   b   c   d   e   f   g   h\n\n"
    return board_string
  end

  def to_json(*args)
    {
      'display' => @display
    }.to_json
  end

  def from_json(args)
    new_display = []
    args['display'].each do |piece|
      new_piece = nil
      case piece['type']
      when 'king'
        new_piece = King.new(piece['color'], piece['position'])
        new_piece.from_json(piece)
      when 'queen'
        new_piece = Queen.new(piece['color'], piece['position'])
      when 'bishop'
        new_piece = Bishop.new(piece['color'], piece['position'])
      when 'knight'
        new_piece = Knight.new(piece['color'], piece['position'])
      when 'rook'
        new_piece = Rook.new(piece['color'], piece['position'])
        new_piece.from_json(piece)
      when 'pawn'
        new_piece = Pawn.new(piece['color'], piece['position'])
        new_piece.from_json(piece)
      end
      new_display << new_piece
    end
    self.instance_variable_set("@display", new_display)
  end
end