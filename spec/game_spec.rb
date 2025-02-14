require_relative '../lib/game'

describe Game do
  describe '#initialize' do
    subject(:game) { described_class.new }
    
    before do
      allow($stdout).to receive(:puts)
      allow(game).to receive(:gets).and_return('no')
    end

    context 'when a new Game object is initialized' do
      it 'creates a new board object' do
        expect(game.board).to be_a(Board)
      end

      it 'creates two player objects' do
        expect(game.player_1).to be_a(Player)
        expect(game.player_2).to be_a(Player)
      end

      it 'creates a checkmate attribute and assigns it to false' do
        expect(game.checkmate).to eq(false)
      end
    end
  end

  describe '#convert_to_coords' do
    subject(:game) { described_class.new }

    before do
      allow($stdout).to receive(:puts)
      allow(game).to receive(:gets).and_return('no')
    end
    
    context 'when a regular move is made' do
      it 'converts the string to the correct position and new location' do
        expect(game.convert_to_coords('e1, d2')).to eq([[7, 4], [6, 3]])
      end
    end

    context 'when a castling move is made' do
      it 'converts the string to the correct position and new location' do
        expect(game.convert_to_coords('e1, 0-0-0')).to eq([[7, 4], ['0-0-0']])
        expect(game.convert_to_coords('e1, 0-0')).to eq([[7, 4], ['0-0']])
      end
    end
  end

  describe '#get_input' do
    subject(:invalid_inputs) { described_class.new }
    subject(:invalid_input_valid_input) { described_class.new }
    subject(:valid_input_invalid_input) { described_class.new }
    subject(:invalid_position) { described_class.new }
    subject(:invalid_new_position) { described_class.new }
    subject(:valid_inputs) { described_class.new }
    subject(:valid_castling_kingside) { described_class.new } 
    subject(:valid_castling_queenside) { described_class.new }
    let(:board_output) { "   +---+---+---+---+---+---+---+---+\n8  | \e[1m\e[31mR\e[0m | \e[1m\e[31mN\e[0m | \e[1m\e[31mB\e[0m | \e[1m\e[31mQ\e[0m | \e[1m\e[31mK\e[0m | \e[1m\e[31mB\e[0m | \e[1m\e[31mN\e[0m | \e[1m\e[31mR\e[0m |\n   +---+---+---+---+---+---+---+---+\n7  | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m |\n   +---+---+---+---+---+---+---+---+\n6  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n5  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n4  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n3  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n2  | \e[1m\e[37mP\e[0m | \e[1m\e[37mP\e[0m | \e[1m\e[37mP\e[0m | \e[1m\e[37mP\e[0m | \e[1m\e[37mP\e[0m | \e[1m\e[37mP\e[0m | \e[1m\e[37mP\e[0m | \e[1m\e[37mP\e[0m |\n   +---+---+---+---+---+---+---+---+\n1  | \e[1m\e[37mR\e[0m | \e[1m\e[37mN\e[0m | \e[1m\e[37mB\e[0m | \e[1m\e[37mQ\e[0m | \e[1m\e[37mK\e[0m | \e[1m\e[37mB\e[0m | \e[1m\e[37mN\e[0m | \e[1m\e[37mR\e[0m |\n   +---+---+---+---+---+---+---+---+\n     a   b   c   d   e   f   g   h\n\n" }
    let(:turn_message_white) { "White's Turn: \n" }
    let(:turn_message_red) { "Red's Turn: \n" }   

    before do
      allow(invalid_inputs).to receive(:gets).and_return("u3, a0")
      allow(invalid_input_valid_input).to receive(:gets).and_return("m10, a6")
      allow(valid_input_invalid_input).to receive(:gets).and_return("g7, t2")
      allow(invalid_position).to receive(:gets).and_return("c8, f3")      
      allow(invalid_new_position).to receive(:gets).and_return("h7, d1")
      allow(valid_inputs).to receive(:puts)
      allow(valid_inputs).to receive(:gets).and_return("e2, e4")
      allow(valid_castling_kingside).to receive(:puts)
      allow(valid_castling_kingside).to receive(:gets).and_return("e1, 0-0")
      allow(valid_castling_queenside).to receive(:puts)
      allow(valid_castling_queenside).to receive(:gets).and_return("e1, 0-0-0")  
    end
    
    context 'when coordinates have invalid characters' do
      it 'returns Invalid Input message' do
        invalid_inputs.board.update_pieces
        player = invalid_inputs.player_1
        expect{ invalid_inputs.get_input(player) }.to output(board_output + turn_message_white + "Invalid Input\n\n").to_stdout
      end  
    end

    context 'when one of the coordinates has invalid characters' do
      it 'returns Invalid Input message' do
        invalid_input_valid_input.board.update_pieces
        iivi_player = invalid_input_valid_input.player_2
        valid_input_invalid_input.board.update_pieces
        viii_player = valid_input_invalid_input.player_2
        expect{ invalid_input_valid_input.get_input(iivi_player) }.to output(board_output + turn_message_red + "Invalid Input\n\n").to_stdout
        expect{ valid_input_invalid_input.get_input(viii_player) }.to output(board_output + turn_message_red + "Invalid Input\n\n").to_stdout
      end
    end

    context 'when the position coordinate is invalid' do
      it 'returns Invalid Input message' do
        invalid_position.board.update_pieces
        player = invalid_position.player_1
        expect{ invalid_position.get_input(player) }.to output(board_output + turn_message_white + "Invalid Input\n\n").to_stdout
      end
    end

    context 'when the new position coordinate is invalid' do
      it 'returns Invalid Input message' do
        invalid_new_position.board.update_pieces
        player = invalid_new_position.player_2
        expect{ invalid_new_position.get_input(player) }.to output(board_output + turn_message_red + "Invalid Input\n\n").to_stdout
      end
    end

    context 'when both coordinates are valid' do
      it 'returns the valid input' do
        valid_inputs.board.update_pieces
        player = valid_inputs.player_1
        expect(valid_inputs.get_input(player)).to eq([[6, 4], [4, 4]])

        valid_castling_kingside.board.display.each do |piece|
          if piece.type == 'king' || piece.type == 'rook' || piece.type == 'pawn'
            next
          else
            piece.position = [nil, nil]
          end
        end
        valid_castling_kingside.board.update_pieces
        castling_player_kingside = valid_castling_kingside.player_1
        expect(valid_castling_kingside.get_input(castling_player_kingside)).to eq([[7, 4], ['0-0']])

        valid_castling_queenside.board.display.each do |piece|
          if piece.type == 'king' || piece.type == 'rook' || piece.type == 'pawn'
            next
          else
            piece.position = [nil, nil]
          end
        end
        valid_castling_queenside.board.update_pieces
        castling_player_queenside = valid_castling_queenside.player_1
        expect(valid_castling_queenside.get_input(castling_player_queenside)).to eq([[7, 4], ['0-0-0']])
      end      
    end
  end

  describe '#checkmate?' do
    subject(:starting_game) { described_class.new }
    subject(:in_progress) { described_class.new }
    subject(:in_check) { described_class.new }
    subject(:in_checkmate) { described_class.new }
    let(:red_king) { double("King", position: [0, 7], possible_moves: [[0, 6], [1, 6]]) }
    let(:check_king) { double("King", position: [0, 7], possible_moves: [[0, 6]]) }
    let(:checkmate_king) { double("King", position: [0, 7], possible_moves: []) }

    let(:board_in_progress_red) { [
      red_king
    ] }
    let(:board_in_check_red) { [
      check_king
    ] }
    let(:board_in_checkmate_red) { [
      checkmate_king
    ] }

    before do
      allow($stdout).to receive(:puts)
      allow(starting_game).to receive(:gets).and_return('no')
      allow(in_progress).to receive(:gets).and_return('no')
      allow(in_check).to receive(:gets).and_return('no')
      allow(in_checkmate).to receive(:gets).and_return('no')
    end

    context 'when the game is starting' do
      it 'the checkmate attribute remains false for both sides' do
        starting_game.board.update_pieces
        player_2 = starting_game.player_2
        starting_game.checkmate?(player_2)
        expect(starting_game.checkmate).to eq(false)
      end
    end
    
    context 'when the game is in progress but there is no checkmate' do
      it 'the checkmate attribute remains false for both sides' do
        in_progress.player_2.my_pieces = board_in_progress_red
        player_2 = in_progress.player_2
        in_progress.checkmate?(player_2)
        expect(in_progress.checkmate).to eq(false)
      end
    end

    context 'when there is a check but no checkmate' do
      it 'the checkmate attribute remains false for both sides' do
        in_check.player_2.my_pieces = board_in_check_red
        player_2 = in_check.player_2 
        in_check.checkmate?(player_2)
        expect(in_check.checkmate).to eq(false)
      end
    end

    context 'when there is a checkmate' do
      it 'the checkmate attribute changes to true for the attacked side' do
        in_checkmate.player_2.my_pieces = board_in_checkmate_red
        player = in_checkmate.player_2
        in_checkmate.checkmate?(player)
        expect(in_checkmate.checkmate).to eq(true)
      end
    end
  end

  describe '#capture' do
    subject(:game) { described_class.new }
    let(:red_queen) { Queen.new('red', [3, 5]) }
    let(:white_king) { King.new('white', [2, 6]) }
    let(:white_bishop) { Bishop.new('white', [0, 5]) }

    let(:board) { [
      red_queen,
      white_king,
      white_bishop
    ] }

    before do
      allow($stdout).to receive(:puts)
      allow(game).to receive(:gets).and_return('no')
    end

    context 'when the enemy piece is captured' do
      it 'the position of enemy piece is changed to nil' do
        game.board.display = board
        enemy_bishop = game.board.display.find {|piece| piece.type == 'bishop' }
        expect(enemy_bishop.position).to eq([0, 5]) 
        game.capture([0, 5])
        expect(enemy_bishop.position).to eq([nil, nil])
      end
    end

    context 'when there is no enemy piece to be captured' do
      it 'no positions for the enemie pieces is changed' do
        game.board.display = board
        enemy_bishop = game.board.display.find { |piece| piece.type == 'bishop' }
        enemy_king = game.board.display.find { |piece| piece.type == 'king' }
        expect(enemy_bishop.position).to eq([0, 5])
        expect(enemy_king.position).to eq([2, 6]) 
        game.capture([3, 2])
        expect(enemy_bishop.position).to eq([0, 5])
        expect(enemy_king.position).to eq([2, 6])
      end
    end

    context 'when the enemy piece is a King' do
      it 'the position of the enemy King is not changed' do
        game.board.display = board
        enemy_king = game.board.display.find {|piece| piece.type == 'king' }
        expect(enemy_king.position).to eq([2, 6]) 
        game.capture([2, 6])
        expect(enemy_king.position).to eq([2, 6])
      end
    end
  end

  describe '#make_castling_move' do
    subject(:game) { described_class.new }
    let(:king) { King.new('red', [0, 4]) }
    let(:left_rook) { Rook.new('red', [0, 0]) }
    let(:right_rook) { Rook.new('red', [0, 7]) }

    let(:board) { [
      king,
      left_rook,
      right_rook
    ] }

    before do
      allow($stdout).to receive(:puts)
      allow(game).to receive(:gets).and_return('no')
    end
    
    context 'when the King makes a queenside castling move' do
      it 'the queenside rook makes a castling move' do
        game.board.display = board
        queenside_rook = game.board.display.find { |piece| piece.position == [0, 0] }
        expect(queenside_rook.position).to eq([0, 0])
        king_pos = king.position
        game.make_castling_move(king_pos, ['0-0-0'])
        expect(queenside_rook.position).to eq([0, 3])
      end
    end

    context 'when the King makes a kingside castling move' do
      it 'the kingside rook makes a castling move' do
        game.board.display = board
        kingside_rook = game.board.display.find { |piece| piece.position == [0, 7] }
        expect(kingside_rook.position).to eq([0, 7])
        king_pos = king.position
        game.make_castling_move(king_pos, ['0-0'])
        expect(kingside_rook.position).to eq([0, 5])
      end
    end

    context 'when the King makes a non castling move' do
      it 'no rooks are moved' do
        game.board.display = board
        queenside_rook = game.board.display.find { |piece| piece.position == [0, 0] }
        kingside_rook = game.board.display.find { |piece| piece.position == [0, 7] }
        expect(queenside_rook.position).to eq([0, 0])
        expect(kingside_rook.position).to eq([0, 7])
        king_pos = king.position
        game.make_castling_move(king_pos, [0, 3])
        expect(queenside_rook.position).to eq([0, 0])
        expect(kingside_rook.position).to eq([0, 7])
      end
    end
  end

  describe '#promote_pawn' do
    subject(:game) { described_class.new }
    let(:promoted_pawn) { Pawn.new('white', [0, 5]) }
    let(:pawn_color) { promoted_pawn.color }
    let(:board) { [promoted_pawn] }

    before do
      allow($stdout).to receive(:puts)
      allow(game).to receive(:gets).and_return('no')
    end
    
    context 'when a Pawn is promoted to a Queen' do
      before do
        allow(game).to receive(:gets).and_return('queen')
      end

      it 'returns a Queen object' do
        game.board.display = board 
        new_piece = game.promote_pawn(pawn_color, [0, 5])
        expect(new_piece.type).to eq('queen')
      end
    end

    context 'when a Pawn is promoted to a Bishop' do
      before do
        allow(game).to receive(:gets).and_return('bishop')
      end

      it 'returns a Bishop object' do
        game.board.display = board 
        new_piece = game.promote_pawn(pawn_color, [0, 5])
        expect(new_piece.type).to eq('bishop')
      end
    end

    context 'when a Pawn is promoted to a Knight' do
      before do
        allow(game).to receive(:gets).and_return('knight')
      end

      it 'returns a Knight object' do
        game.board.display = board 
        new_piece = game.promote_pawn(pawn_color, [0, 5])
        expect(new_piece.type).to eq('knight')
      end
    end

    context 'when a Pawn is promoted to a Rook' do
      before do
        allow(game).to receive(:gets).and_return('rook')
      end

      it 'returns a Rook object' do
        game.board.display = board 
        new_piece = game.promote_pawn(pawn_color, [0, 5])
        expect(new_piece.type).to eq('rook')
      end
    end

    context 'when there is an invalid input given for promotion' do
      before do
        allow(game).to receive(:gets).and_return('pawn', 'luffy', 'stars', 'rook')
      end
      
      it 'asks for a valid input till a valid input is given' do
        game.board.display = board 
        expect(game).to receive(:gets).exactly(4).times
        game.promote_pawn(pawn_color, [0, 5])
      end
    end
  end

  describe '#make_move' do
    subject(:game) { described_class.new }
    let(:en_passant_pawn) { Pawn.new('red', [4, 0]) }
    let(:en_passant_captured) { Pawn.new('white', [4, 1]) }
    let(:king_castling) { King.new('white', [7, 4]) }
    let(:rook_castling) { Rook.new('white', [7, 7]) }
    let(:pawn_promoted) { Pawn.new('red', [6, 6]) }
    let(:new_bishop) { ChessPiece.new('red', 'B', 'bishop', [7, 7]) }
    let(:queen_caputring) { Queen.new('red', [1, 6])}
    let(:knight_captured) { Knight.new('white', [1, 5]) }
    let(:pawn_moving) { Pawn.new('red', [1, 1]) }
    
    let(:board) { [
      en_passant_pawn,
      en_passant_captured,
      king_castling,
      rook_castling,
      pawn_promoted,
      queen_caputring,
      knight_captured,
      pawn_moving
    ] }    

    before do
      allow($stdout).to receive(:puts)
      allow(game).to receive(:gets).and_return('no')
    end

    context 'when the player makes an en passant move' do
      it 'updates the position of the Pawn that made the en passant move' do
        en_passant_pawn.en_passant_moves = [[5, 1]]
        game.board.display = board
        game.player_2.my_pieces = game.board.display.select { |piece| piece.color == 'red' }  
        expect(game).to receive(:capture)
        expect(en_passant_pawn).to receive(:update_position)
        game.make_move(game.player_2, [4, 0], [5, 1])
      end
    end

    context 'when the player makes a castling move' do
      it 'updates the position of the King that made the castling move' do
        game.board.display = board
        game.player_1.my_pieces = game.board.display.select { |piece| piece.color == 'white' }
        expect(game).to receive(:make_castling_move)
        expect(king_castling).to receive(:update_position)
        game.make_move(game.player_1, [7, 4], ['0-0'])
      end
    end

    context 'when the player promotes their pawn' do
      before do
        allow(game).to receive(:promote_pawn).and_return(new_bishop)
      end
      it 'updates the position of the promoted Pawn and ' do
        game.board.display = board
        game.player_2.my_pieces = game.board.display.select { |piece| piece.color == 'red' }
        expect(game).to receive(:promote_pawn)
        expect(pawn_promoted).to receive(:update_position)
        game.make_move(game.player_2, [6, 6], [7, 6])
        expect(game.board.display).to include(new_bishop)
        expect(game.player_2.my_pieces).to include(new_bishop)
      end
    end

    context 'when the player captures an enemy piece' do
      it 'the position of the captured piece is nil and the new position of the caputring piece is where the captured piece was' do
        game.board.display = board
        game.player_1.my_pieces = game.board.display.select { |piece| piece.color == 'white' }
        game.player_2.my_pieces = game.board.display.select { |piece| piece.color == 'red' } 
        capturing_piece = game.board.display.find { |piece| piece.color == 'red' && piece.type == 'queen' }
        captured_piece = game.board.display.find { |piece| piece.color == 'white' && piece.type == 'knight' } 
        expect(capturing_piece.position).to eq([1, 6])
        expect(captured_piece.position).to eq([1, 5])
        game.make_move(game.player_2, [1, 6], [1, 5])
        expect(capturing_piece.position).to eq([1, 5])
        expect(captured_piece.position).to eq([nil, nil])
      end
    end

    context 'when the player does not capture an enemy piece' do
      it "the player's piece is moved to a new position" do
        game.board.display = board
        game.player_2.my_pieces = game.board.display.select { |piece| piece.color == 'red' } 
        expect(pawn_moving.position).to eq([1, 1])
        game.make_move(game.player_2, [1, 1], [2, 1])
        expect(pawn_moving.position).to eq([2, 1])
      end
    end

    context 'when the player tries to move a piece that does not exist' do
      it 'the board does not change' do
        game.board.display = board
        game.player_1.my_pieces = game.board.display.select { |piece| piece.color == 'white' }
        old_board = game.board.display
        game.make_move(game.player_1, [4, 5], [3, 7])
        expect(game.board.display).to eq(old_board)
      end
    end
  end

  describe '#declare_winner' do
    subject(:game) { described_class.new }
  
    context 'when there is a winner' do
      it 'declares the winner of the game' do
        game.winner = 'Player 1'
        expect { game.declare_winner }.to output("Checkmate, Player 1 is the winner!\n").to_stdout
      end
    end

    context 'when there is not a winner' do
      it 'does not print anything' do
        expect { game.declare_winner }.to output("Do you want to load a saved game?\n").to_stdout
      end
    end
  end
end 