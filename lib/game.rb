require_relative 'board'
require_relative 'player'
require_relative 'file_handler'

class Game
  include FileHandler
  
  attr_accessor :board, :player_1, :player_2, :checkmate, :winner

  SAVE_DIRECTORY = './saved_games/'

  def initialize
    puts 'Do you want to load a saved game?'
    answer = gets.chomp.downcase
    if answer == 'yes' || answer == 'y'
      valid_file = nil
      file_name = nil
      until valid_file
        puts "File name?"
        file_name = SAVE_DIRECTORY + gets.chomp
        if File.exist?(file_name)
          break
        end
      end
      load_save(file_name)
    else
      @board = Board.new
      @player_1 = Player.new('white', @board.display.select { |piece| piece.color == 'white'})
      @player_2 = Player.new('red', @board.display.select { |piece| piece.color == 'red'})
      @checkmate = false
      @winner = nil
    end
  end

  def play
    board.update_pieces
    players = nil
    if player_2.inputs.last == ['save']
      players = [@player_2, @player_1]
    else
      players = [@player_1, @player_2]
    end
    puts "\nInstructions:"
    puts '  - When it is your turn to make a move, type in the starting position of your piece, comma, then the new location.'
    puts '    -- Example: a2, a3'
    puts '  - To save a game just type in "save" and follow the prompts.'
    puts '  - At the beginning of each new game, you can load any previous saves by following the prompts.'
    puts "  - Have fun!\n\n"
    while checkmate == false
      players.each do |player|
        checkmate?(player)
        break if @checkmate
        pos, new_pos = nil, nil
        while pos.nil? || new_pos.nil? 
          pos, new_pos = get_input(player)
        end
        if pos == 'file' && new_pos == 'saved'
          puts 'File saved sucessfully'
          return 
        else
          make_move(player, pos, new_pos)
          board.update_pieces
        end
      @winner = player.color.capitalize
      end
    end
    board.update_pieces
    puts board
    declare_winner
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
    puts board
    puts "#{player.color.capitalize}'s Turn: "
    input = gets.chomp.downcase
    if /([a-h][1-8]), (([a-h][1-8])|(0-0-0)|(0-0))/.match(input)
      pos, new_pos = convert_to_coords(input)
      if player.valid_move?(pos, new_pos)
        player.inputs << [input]
        return pos, new_pos
      else
        puts "Invalid Input\n\n"
      end
    elsif input == 'save'
      player.inputs << [input]
      create_save(self)
      return 'file', 'saved'
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
        puts 'What would you like to promote your pawn to?'
        temp = gets.chomp.downcase
        if pieces.include?(temp) 
          new_piece = temp
        end
      end
      promoted_pawn = nil
      case new_piece
      when 'queen'
        promoted_pawn = Queen.new(color, new_pos)
      when 'bishop'
        promoted_pawn = Bishop.new(color, new_pos)
      when 'knight'
        promoted_pawn = Knight.new(color, new_pos)
      when 'rook'
        promoted_pawn = Rook.new(color, new_pos)
      end
      return promoted_pawn 
  end

  def declare_winner
    unless @winner.nil?
      puts "Checkmate, #{@winner} is the winner!"
    end
  end

  def load_save(game_file)
    loaded_save = get_save(game_file)
    loaded_save.each do |key, value|
      if key == 'board'
        new_board = Board.new
        new_board.from_json(value)
        self.instance_variable_set("@#{key}", new_board)
      elsif key == 'player_1' || key == 'player_2'
        new_player = Player.new(value['color'], nil)
        new_player.from_json(value)
        self.instance_variable_set("@#{key}", new_player)
      elsif key == 'checkmate' || key == 'winner'
        self.instance_variable_set("@#{key}", value)
      end
    end
    @player_1.my_pieces = @board.display.select { |piece| piece.color == 'white' }
    @player_2.my_pieces = @board.display.select { |piece| piece.color == 'red' }
  end

  def to_json(*args)
    {
      'board' => @board,
      'player_1' => @player_1,
      'player_2' => @player_2,
      'checkmate' => @checkmate,
      'winner' => @winner
    }.to_json
  end
end