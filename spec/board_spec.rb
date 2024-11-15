require_relative '../lib/board'

describe Board do
  describe '#initialize_board' do
    context 'when the Board class creates a new board' do
      subject(:board) { described_class.new }

      it 'creates a board with all the pieces at their respective starting position' do
        board_array = board.initialize_board
        expect(board_array).to match_array([
          have_attributes(color: 'red', type: 'king', position: [0, 4], moved: 0),
          have_attributes(color: 'red', type: 'queen', position: [0, 3]),
          have_attributes(color: 'red', type: 'bishop', position: [0, 2]),
          have_attributes(color: 'red', type: 'bishop', position: [0, 5]),
          have_attributes(color: 'red', type: 'knight', position: [0, 1]),
          have_attributes(color: 'red', type: 'knight', position: [0, 6]),
          have_attributes(color: 'red', type: 'rook', position: [0, 0], moved: 0),
          have_attributes(color: 'red', type: 'rook', position: [0, 7], moved: 0),
          have_attributes(color: 'red', type: 'pawn', position: [1, 0]),
          have_attributes(color: 'red', type: 'pawn', position: [1, 1]),
          have_attributes(color: 'red', type: 'pawn', position: [1, 2]),
          have_attributes(color: 'red', type: 'pawn', position: [1, 3]),
          have_attributes(color: 'red', type: 'pawn', position: [1, 4]),
          have_attributes(color: 'red', type: 'pawn', position: [1, 5]),
          have_attributes(color: 'red', type: 'pawn', position: [1, 6]),
          have_attributes(color: 'red', type: 'pawn', position: [1, 7]),
          have_attributes(color: 'white', type: 'king', position: [7, 4], moved: 0),
          have_attributes(color: 'white', type: 'queen', position: [7, 3]),
          have_attributes(color: 'white', type: 'bishop', position: [7, 2]),
          have_attributes(color: 'white', type: 'bishop', position: [7, 5]),
          have_attributes(color: 'white', type: 'knight', position: [7, 1]),
          have_attributes(color: 'white', type: 'knight', position: [7, 6]),
          have_attributes(color: 'white', type: 'rook', position: [7, 0], moved: 0),
          have_attributes(color: 'white', type: 'rook', position: [7, 7], moved: 0),
          have_attributes(color: 'white', type: 'pawn', position: [6, 0]),
          have_attributes(color: 'white', type: 'pawn', position: [6, 1]),
          have_attributes(color: 'white', type: 'pawn', position: [6, 2]),
          have_attributes(color: 'white', type: 'pawn', position: [6, 3]),
          have_attributes(color: 'white', type: 'pawn', position: [6, 4]),
          have_attributes(color: 'white', type: 'pawn', position: [6, 5]),
          have_attributes(color: 'white', type: 'pawn', position: [6, 6]),
          have_attributes(color: 'white', type: 'pawn', position: [6, 7])
        ])
      end
    end  
  end

  describe '#initialize' do
    context 'when a new Board object is initialized' do
      it 'calls the initialize_board method to create a new chess board' do
        expect_any_instance_of(Board).to receive(:initialize_board).once
        Board.new
      end
    end
  end

  describe '#update_pieces' do
    subject(:board) { described_class.new }

    context 'when a player makes a valid move' do
      it 'updates all chess pieces on the board' do
        expect(board.display).to match_array([
          have_attributes(position: [0, 4], possible_moves: []),
          have_attributes(position: [0, 3], possible_moves: []),
          have_attributes(position: [0, 2], possible_moves: []),
          have_attributes(position: [0, 5], possible_moves: []),
          have_attributes(position: [0, 1], possible_moves: []),
          have_attributes(position: [0, 6], possible_moves: []),
          have_attributes(position: [0, 0], possible_moves: []),
          have_attributes(position: [0, 7], possible_moves: []),
          have_attributes(position: [1, 0], possible_moves: []),
          have_attributes(position: [1, 1], possible_moves: []),
          have_attributes(position: [1, 2], possible_moves: []),
          have_attributes(position: [1, 3], possible_moves: []),
          have_attributes(position: [1, 4], possible_moves: []),
          have_attributes(position: [1, 5], possible_moves: []),
          have_attributes(position: [1, 6], possible_moves: []),
          have_attributes(position: [1, 7], possible_moves: []),
          have_attributes(position: [7, 4], possible_moves: []),
          have_attributes(position: [7, 3], possible_moves: []),
          have_attributes(position: [7, 2], possible_moves: []),
          have_attributes(position: [7, 5], possible_moves: []),
          have_attributes(position: [7, 1], possible_moves: []),
          have_attributes(position: [7, 6], possible_moves: []),
          have_attributes(position: [7, 0], possible_moves: []),
          have_attributes(position: [7, 7], possible_moves: []),
          have_attributes(position: [6, 0], possible_moves: []),
          have_attributes(position: [6, 1], possible_moves: []),
          have_attributes(position: [6, 2], possible_moves: []),
          have_attributes(position: [6, 3], possible_moves: []),
          have_attributes(position: [6, 4], possible_moves: []),
          have_attributes(position: [6, 5], possible_moves: []),
          have_attributes(position: [6, 6], possible_moves: []),
          have_attributes(position: [6, 7], possible_moves: [])
        ])
        board.update_pieces
        expect(board.display).to match_array([
          have_attributes(position: [0, 4], possible_moves: []),
          have_attributes(position: [0, 3], possible_moves: []),
          have_attributes(position: [0, 2], possible_moves: []),
          have_attributes(position: [0, 5], possible_moves: []),
          have_attributes(position: [0, 1], possible_moves: [[2, 2], [2, 0]]),
          have_attributes(position: [0, 6], possible_moves: [[2, 7], [2, 5]]),
          have_attributes(position: [0, 0], possible_moves: []),
          have_attributes(position: [0, 7], possible_moves: []),
          have_attributes(position: [1, 0], possible_moves: [[2, 0], [3, 0]]),
          have_attributes(position: [1, 1], possible_moves: [[2, 1], [3, 1]]),
          have_attributes(position: [1, 2], possible_moves: [[2, 2], [3, 2]]),
          have_attributes(position: [1, 3], possible_moves: [[2, 3], [3, 3]]),
          have_attributes(position: [1, 4], possible_moves: [[2, 4], [3, 4]]),
          have_attributes(position: [1, 5], possible_moves: [[2, 5], [3, 5]]),
          have_attributes(position: [1, 6], possible_moves: [[2, 6], [3, 6]]),
          have_attributes(position: [1, 7], possible_moves: [[2, 7], [3, 7]]),
          have_attributes(position: [7, 4], possible_moves: []),
          have_attributes(position: [7, 3], possible_moves: []),
          have_attributes(position: [7, 2], possible_moves: []),
          have_attributes(position: [7, 5], possible_moves: []),
          have_attributes(position: [7, 1], possible_moves: [[5, 0], [5, 2]]),
          have_attributes(position: [7, 6], possible_moves: [[5, 5], [5, 7]]),
          have_attributes(position: [7, 0], possible_moves: []),
          have_attributes(position: [7, 7], possible_moves: []),
          have_attributes(position: [6, 0], possible_moves: [[5, 0], [4, 0]]),
          have_attributes(position: [6, 1], possible_moves: [[5, 1], [4, 1]]),
          have_attributes(position: [6, 2], possible_moves: [[5, 2], [4, 2]]),
          have_attributes(position: [6, 3], possible_moves: [[5, 3], [4, 3]]),
          have_attributes(position: [6, 4], possible_moves: [[5, 4], [4, 4]]),
          have_attributes(position: [6, 5], possible_moves: [[5, 5], [4, 5]]),
          have_attributes(position: [6, 6], possible_moves: [[5, 6], [4, 6]]),
          have_attributes(position: [6, 7], possible_moves: [[5, 7], [4, 7]])
        ])
      end
    end
  end

  describe 'to_s' do
    subject(:board_empty) { described_class.new }
    subject(:board_starting) { described_class.new }
    subject(:board_in_progress) { described_class.new }
    subject(:board_captured) { described_class.new }

    let(:red_rook_1) { double(name: "\e[1m\e[31mR\e[0m", position: [0, 0]) }
    let(:red_knight) { double(name: "\e[1m\e[31mN\e[0m", position: [0, 1]) }
    let(:red_rook_2) { double(name: "\e[1m\e[31mR\e[0m", position: [0, 5]) }
    let(:red_king) { double(name: "\e[1m\e[31mK\e[0m", position: [0, 6]) }
    let(:red_pawn_1) { double(name: "\e[1m\e[31mP\e[0m", position: [1, 2]) }
    let(:red_pawn_2) { double(name: "\e[1m\e[31mP\e[0m", position: [1, 5]) }
    let(:red_pawn_3) { double(name: "\e[1m\e[31mP\e[0m", position: [1, 6]) }
    let(:red_pawn_4) { double(name: "\e[1m\e[31mP\e[0m", position: [1, 7]) }
    let(:red_pawn_5) { double(name: "\e[1m\e[31mP\e[0m", position: [2, 0]) }
    let(:red_pawn_6) { double(name: "\e[1m\e[31mP\e[0m", position: [2, 4]) }
    let(:red_pawn_7) { double(name: "\e[1m\e[31mP\e[0m", position: [3, 1]) }
    let(:white_knight_1) { double(name: "\e[1m\e[37mN\e[0m", position: [3, 4]) }
    let(:white_knight_2) { double(name: "\e[1m\e[37mN\e[0m", position: [3, 6]) }
    let(:red_bishop) { double(name: "\e[1m\e[31mB\e[0m", position: [4, 1]) }
    let(:white_pawn_1) { double(name: "\e[1m\e[37mP\e[0m", position: [4, 2]) }
    let(:white_pawn_2) { double(name: "\e[1m\e[37mP\e[0m", position: [5, 6]) }
    let(:red_queen) { double(name: "\e[1m\e[31mQ\e[0m", position: [6, 0]) }
    let(:white_bishop) { double(name: "\e[1m\e[37mB\e[0m", position: [6, 1]) }
    let(:white_queen) { double(name: "\e[1m\e[37mQ\e[0m", position: [6, 4]) }
    let(:white_pawn_3) { double(name: "\e[1m\e[37mP\e[0m", position: [6, 5]) }
    let(:white_king) { double(name: "\e[1m\e[37mK\e[0m", position: [6, 6]) }
    let(:white_pawn_4) { double(name: "\e[1m\e[37mP\e[0m", position: [6, 7]) }
    let(:white_rook) { double(name: "\e[1m\e[37mR\e[0m", position: [7, 5]) }
    let(:captured_red_rook_1) { double(name: "\e[1m\e[31mR\e[0m", position: [nil, nil]) }
    let(:captured_red_pawn_1) { double(name: "\e[1m\e[31mP\e[0m", position: [nil, nil]) }
    let(:captured_red_pawn_5) { double(name: "\e[1m\e[31mP\e[0m", position: [nil, nil]) }
    let(:captured_red_pawn_7) { double(name: "\e[1m\e[31mP\e[0m", position: [nil, nil]) }
    let(:captured_red_bishop) { double(name: "\e[1m\e[31mB\e[0m", position: [nil, nil]) }
    let(:captured_white_pawn_2) { double(name: "\e[1m\e[37mP\e[0m", position: [nil, nil]) }
    let(:captured_red_queen) { double(name: "\e[1m\e[31mQ\e[0m", position: [nil, nil]) }
    let(:captured_white_rook) { double(name: "\e[1m\e[37mR\e[0m", position: [nil, nil]) }
    
    context 'when the board is object is initialized' do
      it 'returns the string representation of the starting board' do
        expect(board_starting.to_s).to eq("   +---+---+---+---+---+---+---+---+\n8  | \e[1m\e[31mR\e[0m | \e[1m\e[31mN\e[0m | \e[1m\e[31mB\e[0m | \e[1m\e[31mQ\e[0m | \e[1m\e[31mK\e[0m | \e[1m\e[31mB\e[0m | \e[1m\e[31mN\e[0m | \e[1m\e[31mR\e[0m |\n   +---+---+---+---+---+---+---+---+\n7  | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m |\n   +---+---+---+---+---+---+---+---+\n6  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n5  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n4  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n3  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n2  | \e[1m\e[37mP\e[0m | \e[1m\e[37mP\e[0m | \e[1m\e[37mP\e[0m | \e[1m\e[37mP\e[0m | \e[1m\e[37mP\e[0m | \e[1m\e[37mP\e[0m | \e[1m\e[37mP\e[0m | \e[1m\e[37mP\e[0m |\n   +---+---+---+---+---+---+---+---+\n1  | \e[1m\e[37mR\e[0m | \e[1m\e[37mN\e[0m | \e[1m\e[37mB\e[0m | \e[1m\e[37mQ\e[0m | \e[1m\e[37mK\e[0m | \e[1m\e[37mB\e[0m | \e[1m\e[37mN\e[0m | \e[1m\e[37mR\e[0m |\n   +---+---+---+---+---+---+---+---+\n     a   b   c   d   e   f   g   h\n\n")
      end
    end

    context 'when the board is empty' do
      it 'returns the string representation of an empty board' do
        board_empty.display = []
        expect(board_empty.to_s).to eq("   +---+---+---+---+---+---+---+---+\n8  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n7  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n6  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n5  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n4  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n3  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n2  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n1  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n     a   b   c   d   e   f   g   h\n\n")
      end
    end

    context 'when the board has pieces moved' do
      it 'returns the string representation of the board with the pieces moved' do
        board_in_progress.display = [
          red_rook_1,
          red_knight,
          red_rook_2,
          red_king,
          red_pawn_1,
          red_pawn_2,
          red_pawn_3,
          red_pawn_4,
          red_pawn_5,
          red_pawn_6,
          red_pawn_7,
          white_knight_1,
          white_knight_2,
          red_bishop,
          white_pawn_1,
          white_pawn_2,
          red_queen,
          white_bishop,
          white_queen,
          white_pawn_3,
          white_king,
          white_pawn_4,
          white_rook
        ]
        expect(board_in_progress.to_s).to eq("   +---+---+---+---+---+---+---+---+\n8  | \e[1m\e[31mR\e[0m | \e[1m\e[31mN\e[0m |   |   |   | \e[1m\e[31mR\e[0m | \e[1m\e[31mK\e[0m |   |\n   +---+---+---+---+---+---+---+---+\n7  |   |   | \e[1m\e[31mP\e[0m |   |   | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m |\n   +---+---+---+---+---+---+---+---+\n6  | \e[1m\e[31mP\e[0m |   |   |   | \e[1m\e[31mP\e[0m |   |   |   |\n   +---+---+---+---+---+---+---+---+\n5  |   | \e[1m\e[31mP\e[0m |   |   | \e[1m\e[37mN\e[0m |   | \e[1m\e[37mN\e[0m |   |\n   +---+---+---+---+---+---+---+---+\n4  |   | \e[1m\e[31mB\e[0m | \e[1m\e[37mP\e[0m |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n3  |   |   |   |   |   |   | \e[1m\e[37mP\e[0m |   |\n   +---+---+---+---+---+---+---+---+\n2  | \e[1m\e[31mQ\e[0m | \e[1m\e[37mB\e[0m |   |   | \e[1m\e[37mQ\e[0m | \e[1m\e[37mP\e[0m | \e[1m\e[37mK\e[0m | \e[1m\e[37mP\e[0m |\n   +---+---+---+---+---+---+---+---+\n1  |   |   |   |   |   | \e[1m\e[37mR\e[0m |   |   |\n   +---+---+---+---+---+---+---+---+\n     a   b   c   d   e   f   g   h\n\n")
      end
    end

    context 'when there are chess pieces that have been captured' do
      it 'returns a string that not contain the captured chess pieces' do
        board_captured.display = [
          captured_red_rook_1,
          red_knight,
          red_rook_2,
          red_king,
          captured_red_pawn_1,
          red_pawn_2,
          red_pawn_3,
          red_pawn_4,
          captured_red_pawn_5,
          red_pawn_6,
          captured_red_pawn_7,
          white_knight_1,
          white_knight_2,
          captured_red_bishop,
          white_pawn_1,
          captured_white_pawn_2,
          captured_red_queen,
          white_bishop,
          white_queen,
          white_pawn_3,
          white_king,
          white_pawn_4,
          captured_white_rook
        ]
        expect(board_captured.to_s).to eq("   +---+---+---+---+---+---+---+---+\n8  |   | \e[1m\e[31mN\e[0m |   |   |   | \e[1m\e[31mR\e[0m | \e[1m\e[31mK\e[0m |   |\n   +---+---+---+---+---+---+---+---+\n7  |   |   |   |   |   | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m | \e[1m\e[31mP\e[0m |\n   +---+---+---+---+---+---+---+---+\n6  |   |   |   |   | \e[1m\e[31mP\e[0m |   |   |   |\n   +---+---+---+---+---+---+---+---+\n5  |   |   |   |   | \e[1m\e[37mN\e[0m |   | \e[1m\e[37mN\e[0m |   |\n   +---+---+---+---+---+---+---+---+\n4  |   |   | \e[1m\e[37mP\e[0m |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n3  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n2  |   | \e[1m\e[37mB\e[0m |   |   | \e[1m\e[37mQ\e[0m | \e[1m\e[37mP\e[0m | \e[1m\e[37mK\e[0m | \e[1m\e[37mP\e[0m |\n   +---+---+---+---+---+---+---+---+\n1  |   |   |   |   |   |   |   |   |\n   +---+---+---+---+---+---+---+---+\n     a   b   c   d   e   f   g   h\n\n")
      end
    end
  end
end