require_relative 'board'
require_relative 'player'

class Game
  attr_accessor :board, :player_1, :player_2, :checkmate

  def initialize
    @board = Board.new
    @player_1 = Player.new('white', @board.display.select { |piece| piece.color == 'white'})
    @player_2 = Player.new('red', @board.display.select { |piece| piece.color == 'red'})
    @checkmate = false
  end

  def make_move(player, pos, new_pos)
    player.my_pieces.each do |piece|
      if piece.position == pos  
        if piece.type == "pawn" && piece.en_passant_moves.any? { |move| move.include?(new_pos) }
          opponent_piece = piece.en_passant_moves.find {|move| move[0] == new_pos}
          capture(opponent_piece[1])
        elsif piece.type == "king" && (new_pos == ['0-0-0'] || new_pos == ['0-0'])
          make_castling_move(piece.position, new_pos)
        elsif piece.type == "pawn" && (new_pos[0] == 0 || new_pos[0] == 7)
          promoted_pawn = promote_pawn(piece.color, new_pos)
          board.display << promoted_pawn
          player.my_pieces << promoted_pawn
        else
          capture(new_pos)
        end
        piece.update_position(new_pos)
        break
      end
    end
  end
  
  def get_input(player)
    puts "#{player.color.capitalize}'s Turn: "
    input = gets.chomp
    if /([a-h][1-8]), (([a-h][1-8])|(0-0-0)|(0-0))/.match(input)
      pos, new_pos = convert_to_coords(input)
      if player.valid_move?(pos, new_pos)
        return pos, new_pos
      else
        puts "Invalid Input\n\n"
      end
    else
      puts "Invalid Input\n\n"
    end
  end
  
  def convert_to_coords(str)
    conversion_table = {
      'a' => 0, 
      'b' => 1, 
      'c' => 2, 
      'd' => 3, 
      'e' => 4, 
      'f' => 5, 
      'g' => 6, 
      'h' => 7,
      '8' => 0, 
      '7' => 1, 
      '6' => 2, 
      '5' => 3, 
      '4' => 4, 
      '3' => 5, 
      '2' => 6, 
      '1' => 7
    }
    pos = []
    new_pos = []

    coordinates = str.downcase.split(',')
    unconverted_pos = coordinates[0].split('')
    unconverted_pos.each do |position|
      pos.unshift(conversion_table.fetch(position))
    end

    unconverted_new_pos = coordinates[1].strip
    if unconverted_new_pos == '0-0-0' || unconverted_new_pos == '0-0'
      new_pos << unconverted_new_pos
    else
      unconverted_new_pos = unconverted_new_pos.split('')
      unconverted_new_pos.each do |position|
        new_pos.unshift(conversion_table.fetch(position))
      end
    end
    return pos, new_pos
  end

  def checkmate?(player)
    player.my_pieces.each do |piece|
      if piece.possible_moves.empty? == false
        return
      end
    end
    @checkmate = true
  end

  def capture(new_pos)
    board.display.each do |piece|
      if piece.position == new_pos && piece.type != 'king'
        piece.update_position([nil, nil])
        break
      end
    end
  end

  def make_castling_move(king_pos, new_pos)
    case new_pos
    when ['0-0-0']
      rook_pos = [king_pos[0], 0]
      rook_new_pos = [king_pos[0], 3]
    when ['0-0']
      rook_pos = [king_pos[0], 7]
      rook_new_pos = [king_pos[0], 5]
    else
      return
    end
    board.display.each do |piece|
      if piece.type == 'rook' && piece.position == rook_pos
        piece.update_position(rook_new_pos)
      end
    end
  end

  def promote_pawn(color, new_pos)
    pieces = ['queen', 'bishop', 'knight', 'rook']
      new_piece = nil
      until new_piece
        temp = gets.chomp.downcase
        if pieces.include?(temp) 
          new_piece = temp
        end
      end
      promoted_pawn = nil
      case new_piece
      when 'queen'
        promoted_pawn = ChessPiece.new(color, 'Q', 'queen', new_pos)
      when 'bishop'
        promoted_pawn = ChessPiece.new(color, 'B', 'bishop', new_pos)
      when 'knight'
        promoted_pawn = ChessPiece.new(color, 'N', 'knight', new_pos)
      when 'rook'
        promoted_pawn = ChessPiece.new(color, 'R', 'rook', new_pos)
      end
      return promoted_pawn 
  end
end