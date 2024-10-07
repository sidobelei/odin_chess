require_relative '../lib/chess_piece'

describe ChessPiece do
  describe '#initialize' do
    subject(:chess_piece_red) { described_class.new("ReD", "N", 'knight', [0, 6] ) }
    subject(:chess_piece_white) {described_class.new("whIte", "P", 'pawn', [5, 2]) }
    
    context 'when ChessPiece object is initialized' do
      context 'when the color is either red or white'
      it 'assigns a color to the color attribute' do
        expect(chess_piece_red.color).to eq("red")
        expect(chess_piece_white.color).to eq("white")
      end
      
      it "assigns a name to the name attribute" do
        expect(chess_piece_red.name).to eq("\e[1m\e[31mN\e[0m")
        expect(chess_piece_white.name).to eq("\e[1m\e[37mP\e[0m")
      end

      it 'assigns the type of chess piece to the type attribute' do
        expect(chess_piece_red.type).to eq('knight')
        expect(chess_piece_white.type).to eq('pawn')
      end

      it 'creates an empty array for possible_moves' do
        expect(chess_piece_red.possible_moves).to eq([])
        expect(chess_piece_white.possible_moves).to eq([])
      end

      it 'assigns coordinates to the position attribute' do
        expect(chess_piece_red.position).to eq([0, 6])
        expect(chess_piece_white.position).to eq([5, 2])
      end

      subject(:invalid_color_piece) { described_class.new("green", "K", 'king', [0, 0]) }
      subject(:invalid_position_piece) { described_class.new("red", "K", 'king', [-1, 7]) }
      subject(:invalid_position_piece2) { described_class.new("red", "K", 'king', [0, 70]) }
      context 'when given invalid inputs' do
        it 'raises an error for an invalid color input' do
          expect { invalid_color_piece }.to raise_error(ArgumentError, 'Invalid color input')
        end

        it 'raises an error for an invalid coordinates input' do
          expect { invalid_position_piece }.to raise_error(ArgumentError, 'Invalid coordinates input')
          expect { invalid_position_piece2 }.to raise_error(ArgumentError, 'Invalid coordinates input')
        end
      end
    end
  end

  describe '#update_position' do
    subject(:old_position) { described_class.new('red', 'B', 'bishop', [7, 2]) }
    
    before do
      allow(old_position).to receive(:update_possible_moves)
    end
    
    context 'when a new chess position is given' do
      it 'updates the current position of the chess piece' do
        expect { old_position.update_position([5,3]) }.to change { old_position.position }.to([5, 3])
      end
    end
  end

  describe '#out_of_bounds?' do
    subject(:in_bounds) { described_class.new('white', 'Q', 'queen', [7, 5] )}
    subject(:out_bounds) { described_class.new('red', 'R', 'rook', [0, 2]) }
    
    context 'when given a position that is not out of bounds of the board' do
      it 'returns false' do
        expect(in_bounds.out_of_bounds?([7, 0])).to eq(false)
        expect(in_bounds.out_of_bounds?([7, 7])).to eq(false)
        expect(in_bounds.out_of_bounds?([0, 7])).to eq(false)
        expect(in_bounds.out_of_bounds?([0, 0])).to eq(false)
        expect(in_bounds.out_of_bounds?([4, 3])).to eq(false)
      end
    end

    context 'when given a position that is out of bounds' do
      it 'returns true' do
        expect(out_bounds.out_of_bounds?([-1, 7])).to eq(true)
        expect(out_bounds.out_of_bounds?([-1, 0])).to eq(true)
        expect(out_bounds.out_of_bounds?([8, 0])).to eq(true)
        expect(out_bounds.out_of_bounds?([8, 7])).to eq(true)
        expect(out_bounds.out_of_bounds?([-100, 800])).to eq(true)
      end
    end
  end

  describe '#king_or_same_color?' do
    subject(:king1) { described_class.new('red', 'K', 'king', [0, 1]) }
    subject(:king2) { described_class.new('red', 'K', 'king', [7, 6]) }
    subject(:rook1) { described_class.new('red', 'R', 'rook', [0, 2]) }
    subject(:rook2) { described_class.new('red', 'R', 'rook', [0, 3]) }
    subject(:pawn1) { described_class.new('red', 'P', 'pawn', [1, 0]) }
    subject(:pawn2) { described_class.new('red', 'P', 'pawn', [1, 1]) }
    subject(:pawn3) { described_class.new('red', 'P', 'pawn', [1, 5]) }
    subject(:pawn4) { described_class.new('red', 'P', 'pawn', [1, 6]) }
    subject(:pawn5) { described_class.new('red', 'P', 'pawn', [1, 7]) }
    subject(:knight1) { described_class.new('red', 'N', 'knight', [4, 2]) }
    subject(:bishop) { described_class.new('white', 'B', 'bishop', [3, 4]) }
    subject(:rook3) { described_class.new('white', 'R', 'rook', [7, 4]) }
    subject(:queen) { described_class.new('white', 'Q', 'queen', [3, 6]) }
    let(:board) { [
      king1,
      king2,
      rook1,
      rook2,
      pawn1,
      pawn2,
      pawn3,
      pawn4,
      pawn5,
      knight1,
      bishop,
      rook3,
      queen
    ] }
    context 'when a King occupies the square on the board that you want to move to' do
      it 'returns true' do
        expect(bishop.king_or_same_color?(board, [0, 1])).to eq(true)
        expect(bishop.king_or_same_color?(board, [7, 6])).to eq(true)
      end
    end

    context 'when the square on the board is occupied by your own chess piece' do
      it 'returns true' do
        expect(rook1.king_or_same_color?(board, [0, 3])).to eq(true)
        expect(rook1.king_or_same_color?(board, [4, 2])).to eq(true)
        expect(king1.king_or_same_color?(board, [1, 0])).to eq(true)
      end
    end

    context 'when the square on the board is empty and you move your chess piece to it' do
      it 'returns false' do
        expect(queen.king_or_same_color?(board, [2, 6])).to eq(false)
        expect(queen.king_or_same_color?(board, [2, 7])).to eq(false)
        expect(queen.king_or_same_color?(board, [3, 7])).to eq(false)
        expect(queen.king_or_same_color?(board, [4, 7])).to eq(false)
        expect(queen.king_or_same_color?(board, [4, 6])).to eq(false)
        expect(queen.king_or_same_color?(board, [4, 5])).to eq(false)
        expect(queen.king_or_same_color?(board, [3, 5])).to eq(false)
        expect(queen.king_or_same_color?(board, [2, 5])).to eq(false)
      end
    end
  end

  describe '#opponent_piece?' do
    subject(:king1) { described_class.new('red', 'K', 'king', [0, 0]) }
    subject(:king2) { described_class.new('white', 'K', 'king', [7,7]) }
    subject(:rook1) { described_class.new('red', 'R', 'rook', [0, 1]) }
    subject(:rook2) { described_class.new('red', 'R', 'rook', [7, 4]) }
    subject(:rook3) { described_class.new('white', 'R', 'rook', [0, 1]) }
    subject(:rook4) { described_class.new('white', 'R', 'rook', [7, 4]) }
    subject(:bishop1) { described_class.new('red', 'B', 'bishop', [0, 4]) }
    subject(:bishop2) { described_class.new('red', 'B', 'bishop', [6, 7]) }
    subject(:bishop3) { described_class.new('white', 'B', 'bishop', [0, 4]) }
    subject(:bishop4) { described_class.new('white', 'B', 'bishop', [6, 7]) }
    subject(:pawn1) { described_class.new('red', 'P', 'pawn', [3, 0]) }
    subject(:pawn2) { described_class.new('red', 'P', 'pawn', [3, 7]) }
    subject(:pawn3) { described_class.new('red', 'P', 'pawn', [7, 4]) }
    subject(:pawn4) { described_class.new('white', 'P', 'pawn', [3, 0]) }
    subject(:pawn5) { described_class.new('white', 'P', 'pawn', [3, 7]) }
    subject(:pawn6) { described_class.new('white', 'P', 'pawn', [7, 4]) }
    subject(:knight1) { described_class.new('red', 'N', 'knight', [7, 0]) }
    subject(:knight2) { described_class.new('white', 'N', 'knight', [7, 0]) }
    subject(:queen1) { described_class.new('red', 'Q', 'queen', [3, 4]) }
    
    let(:board_self) { [
      king1,
      king2,
      rook1,
      rook2,
      bishop1,
      bishop2,
      pawn1,
      pawn2,
      pawn3,
      knight1,
      queen1
    ] }

    let(:board_opponent) { [
      king1,
      king2,
      rook3,
      rook4,
      bishop3,
      bishop4,
      pawn4,
      pawn5,
      pawn6,
      knight2,
      queen1
    ] }

    context 'when the square on the board is occupied by a piece from your side' do
      it 'returns false' do
        expect(queen1.opponent_piece?(board_self, [0, 1])).to eq(false)
        expect(queen1.opponent_piece?(board_self, [7, 4])).to eq(false)
        expect(queen1.opponent_piece?(board_self, [0, 4])).to eq(false)
        expect(queen1.opponent_piece?(board_self, [6, 7])).to eq(false)
        expect(queen1.opponent_piece?(board_self, [3, 0])).to eq(false)
        expect(queen1.opponent_piece?(board_self, [3, 7])).to eq(false)
        expect(queen1.opponent_piece?(board_self, [7, 4])).to eq(false)
        expect(queen1.opponent_piece?(board_self, [7, 0])).to eq(false)
      end
    end

    context 'when the square on the board is occupied by a piece from the opponent' do
      it 'returns true' do
        expect(queen1.opponent_piece?(board_opponent, [0, 1])).to eq(true)
        expect(queen1.opponent_piece?(board_opponent, [7, 4])).to eq(true)
        expect(queen1.opponent_piece?(board_opponent, [0, 4])).to eq(true)
        expect(queen1.opponent_piece?(board_opponent, [6, 7])).to eq(true)
        expect(queen1.opponent_piece?(board_opponent, [3, 0])).to eq(true)
        expect(queen1.opponent_piece?(board_opponent, [3, 7])).to eq(true)
        expect(queen1.opponent_piece?(board_opponent, [7, 4])).to eq(true)
        expect(queen1.opponent_piece?(board_opponent, [7, 0])).to eq(true)
      end
    end
  end
end