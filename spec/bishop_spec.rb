require_relative '../lib/bishop'

describe Bishop do
  describe '#initialize' do
    subject(:bishop) { described_class.new('red', [7, 2])}

    context 'when a Bishop object is initialized' do
      it 'assigns a color attribute' do
        expect(bishop.color).to eq('red')    
      end

      it 'assigns a name attribute' do
        expect(bishop.name).to eq("\e[1m\e[31mB\e[0m")
      end

      it 'assigns a type attribute' do
        expect(bishop.type).to eq("bishop")
      end

      it 'assigns a position attribute' do
        expect(bishop.position).to eq([7, 2])
      end
    end
  end

  describe '#update_possible_moves' do
    let(:bishop) { described_class.new('white', [3, 3]) }
    let(:king1) { double("King", color: 'red', name: 'K', type: 'king', position: [0, 1]) }
    let(:rook1) { double("Rook", color: 'red', name: 'R', type: 'rook', position: [0, 2]) }
    let(:rook2) { double("Rook", color: 'red', name: 'R', type: 'rook', position: [0, 3]) }
    let(:pawn1) { double("Pawn", color: 'red', name: 'P', type: 'pawn', position: [1, 0]) }
    let(:pawn2) { double("Pawn", color: 'red', name: 'P', type: 'pawn', position: [1, 1]) }
    let(:pawn3) { double("Pawn", color: 'red', name: 'P', type: 'pawn', position: [1, 5]) }
    let(:pawn4) { double("Pawn", color: 'white', name: 'P', type: 'pawn', position: [2, 2]) }
    let(:pawn5) { double("Pawn", color: 'white', name: 'P', type: 'pawn', position: [2, 3]) }
    let(:pawn6) { double("Pawn", color: 'white', name: 'P', type: 'pawn', position: [2, 4]) }
    let(:pawn7) { double("Pawn", color: 'white', name: 'P', type: 'pawn', position: [3, 2]) }
    let(:pawn8) { double("Pawn", color: 'white', name: 'P', type: 'pawn', position: [3, 4]) }
    let(:pawn9) { double("Pawn", color: 'white', name: 'P', type: 'pawn', position: [4, 2]) }
    let(:pawn10) { double("Pawn", color: 'white', name: 'P', type: 'pawn', position: [4, 3]) }
    let(:pawn11) { double("Pawn", color: 'white', name: 'P', type: 'pawn', position: [4, 4]) }
    let(:pawn12) { double("Pawn", color: 'red', name: 'P', type: 'pawn', position: [2, 2]) }
    let(:pawn13) { double("Pawn", color: 'red', name: 'P', type: 'pawn', position: [2, 3]) }
    let(:pawn14) { double("Pawn", color: 'red', name: 'P', type: 'pawn', position: [2, 4]) }
    let(:pawn15) { double("Pawn", color: 'red', name: 'P', type: 'pawn', position: [3, 2]) }
    let(:pawn16) { double("Pawn", color: 'red', name: 'P', type: 'pawn', position: [3, 4]) }
    let(:pawn17) { double("Pawn", color: 'red', name: 'P', type: 'pawn', position: [4, 2]) }
    let(:pawn18) { double("Pawn", color: 'red', name: 'P', type: 'pawn', position: [4, 3]) }
    let(:pawn19) { double("Pawn", color: 'red', name: 'P', type: 'pawn', position: [4, 4]) }
    let(:knight) { double("Knight", color: 'red', name: 'N', type: 'knight', position: [4, 2]) }
    let(:king2) { double("King", color: 'white', name: 'K', type: 'king', position: [5, 5]) }
    let(:board_clear) { [
      bishop,
      king1,
      rook1,
      rook2,
      pawn1,
      king2
    ] }
    let(:board_obstructed) { [
      bishop,
      king1,
      rook1,
      rook2,
      pawn1,
      pawn2,
      pawn3,
      knight,
      king2
    ] }
    let(:board_boxed_in_same) {[
      bishop,
      king1,
      pawn4,
      pawn5,
      pawn6,
      pawn7,
      pawn8,
      pawn9,
      pawn10,
      pawn11,
      king2
    ]}
    let(:board_boxed_in_opposite) {[
      bishop,
      king1,
      pawn12,
      pawn13,
      pawn14,
      pawn15,
      pawn16,
      pawn17,
      pawn18,
      pawn19,
      king2
    ]}

    context 'when there are no pieces in the path of the bishop' do
      before do
        allow(bishop).to receive(:out_of_bounds?).and_return(false, false, false, true, false, false, false, true, false, false, false, true, false, false, false, false, true)
        allow(bishop).to receive(:king_or_same_color?).and_return(false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false)
        allow(bishop).to receive(:opponent_piece?).and_return(false, false, false, false, false, false, false, false, false, false, false, false, false)
      end

      it 'possible_moves has all moves' do
        bishop.update_possible_moves(board_clear)
        expect(bishop.possible_moves).to eq([
          [2, 2],
          [1, 1],
          [0, 0],
          [2, 4],
          [1, 5],
          [0, 6],
          [4, 2],
          [5, 1],
          [6, 0],
          [4, 4],
          [5, 5],
          [6, 6],
          [7, 7]
        ])
      end
    end

    context 'when there are chess pieces in the path of the bishop' do
      before do
        allow(bishop).to receive(:out_of_bounds?).and_return(false, false, false, false, false, false, false)
        allow(bishop).to receive(:king_or_same_color?).and_return(false, false, false, false, false, false, true)
        allow(bishop).to receive(:opponent_piece?).and_return(false, true, false, true, true, false, false)
      end

      it 'possible_moves has a limited set of moves' do
        bishop.update_possible_moves(board_obstructed)
        expect(bishop.possible_moves).to eq([
          [2, 2],
          [1, 1],
          [2, 4],
          [1, 5],
          [4, 2],
          [4, 4]
        ])
      end
    end

    context 'when the bishop is surrounded by chess pieces of the same color' do
      before do
        allow(bishop).to receive(:out_of_bounds?).and_return(false, false, false, false)
        allow(bishop).to receive(:king_or_same_color?).and_return(true, true, true)
        allow(bishop).to receive(:opponent_piece?).and_return(false, false, false, false)
      end

      it 'generates an empty set of moves for possible_moves' do
        bishop.update_possible_moves(board_boxed_in_same)
        expect(bishop.possible_moves).to eq([])
      end
    end

    context 'when the bishop is surrounded by chess pieces of the opposite color' do
      before do
        allow(bishop).to receive(:out_of_bounds?).and_return(false, false, false, false)
        allow(bishop).to receive(:king_or_same_color?).and_return(false, false, false, false)
        allow(bishop).to receive(:opponent_piece?).and_return(true, true, true, true)
      end

      it 'generates reduced set of moves for possible_moves' do
        bishop.update_possible_moves(board_boxed_in_opposite)
        expect(bishop.possible_moves).to eq([
          [2, 2],
          [2, 4],
          [4, 2],
          [4, 4]
        ])
      end
    end

    context 'when the bishop is positioned at the top of the board' do
      before do
        allow(bishop).to receive(:out_of_bounds?).and_return(true, true, false, false, false, false, true, false, false, false, true)
        allow(bishop).to receive(:king_or_same_color?).and_return(false, false, false, false, false, false, false)
        allow(bishop).to receive(:opponent_piece?).and_return(false, false, false, false, false, false, false)
      end

      it 'generates the correct set of valid moves' do
        bishop.update_position([0, 4])
        bishop.update_possible_moves(board_clear)
        expect(bishop.possible_moves).to eq([
          [1, 3],
          [2, 2],
          [3, 1],
          [4, 0],
          [1, 5],
          [2, 6],
          [3, 7]
        ])
      end
    end

    context 'when the bishop is positioned on the left edge of the board' do
      before do
        allow(bishop).to receive(:out_of_bounds?).and_return(true, false, false, false, false, true, true, false, false, false, true)
        allow(bishop).to receive(:king_or_same_color?).and_return(false, false, false, false, false, false, false)
        allow(bishop).to receive(:opponent_piece?).and_return(false, false, false, false, false, false, false)
      end

      it 'generates the correct set of valid moves' do
        bishop.update_position([4, 0])
        bishop.update_possible_moves(board_clear)
        expect(bishop.possible_moves).to eq([
          [3, 1],
          [2, 2],
          [1, 3],
          [0, 4],
          [5, 1],
          [6, 2],
          [7, 3]
        ])
      end
    end

    context 'when the bishop is positioned on the right edge of the board' do
      before do
        allow(bishop).to receive(:out_of_bounds?).and_return(false, false, true, true, false, false, false, false, false, true, true)
        allow(bishop).to receive(:king_or_same_color?).and_return(false, false, false, false, false, false, false)
        allow(bishop).to receive(:opponent_piece?).and_return(false, false, false, false, false, false, false)
      end

      it 'generates the correct set of valid moves' do
        bishop.update_position([2, 7])
        bishop.update_possible_moves(board_clear)
        expect(bishop.possible_moves).to eq([
          [1, 6],
          [0, 5],
          [3, 6],
          [4, 5],
          [5, 4],
          [6, 3],
          [7, 2]
        ])
      end
    end

    context 'when the bishop is positioned at the bottom of the board' do
      before do
        allow(bishop).to receive(:out_of_bounds?).and_return(false, false, true, false, false, false, false, false, true, true)
        allow(bishop).to receive(:king_or_same_color?).and_return(false, false, false, false, false, false, false)
        allow(bishop).to receive(:opponent_piece?).and_return(false, false, false, false, false, false, false)
      end

      it 'generates the correct set of valid moves' do
        bishop.update_position([7, 2])
        bishop.update_possible_moves(board_clear)
        expect(bishop.possible_moves).to eq([
          [6, 1],
          [5, 0],
          [6, 3],
          [5, 4],
          [4, 5],
          [3, 6],
          [2, 7]
        ])
      end
    end

    context 'when the bishop is positioned at the left corner of the board' do
      before do
        allow(bishop).to receive(:out_of_bounds?).and_return(true, true, true, false, false, false, false, false, false, false, true)
        allow(bishop).to receive(:king_or_same_color?).and_return(false, false, false, false, false, false, false)
        allow(bishop).to receive(:opponent_piece?).and_return(false, false, false, false, false, false, false)
      end

      it 'generates the correct set of valid moves' do
        bishop.update_position([0, 0])
        bishop.update_possible_moves(board_clear)
        expect(bishop.possible_moves).to eq([
          [1, 1],
          [2, 2],
          [3, 3],
          [4, 4],
          [5, 5],
          [6, 6],
          [7, 7]
        ])
      end
    end

    context 'when the bishop is positioned at the top right corner of the board' do
      before do
        allow(bishop).to receive(:out_of_bounds?).and_return(true, true, false, false, false, false, false, false, false, true, true)
        allow(bishop).to receive(:king_or_same_color?).and_return(false, false, false, false, false, false, false)
        allow(bishop).to receive(:opponent_piece?).and_return(false, false, false, false, false, false, false)
      end

      it 'generates the correct set of valid moves' do
        bishop.update_position([0, 7])
        bishop.update_possible_moves(board_clear)
        expect(bishop.possible_moves).to eq([
          [1, 6],
          [2, 5],
          [3, 4],
          [4, 3],
          [5, 2],
          [6, 1],
          [7, 0]
        ])
      end
    end

    context 'when the bishop is positioned at the bottom left corner of the board' do
      before do
        allow(bishop).to receive(:out_of_bounds?).and_return(true, false, false, false, false, false, false, false, true, true, true)
        allow(bishop).to receive(:king_or_same_color?).and_return(false, false, false, false, false, false, false, false)
        allow(bishop).to receive(:opponent_piece?).and_return(false, false, false, false, false, false, false, false)
      end

      it 'generates the correct set of valid moves' do
        bishop.update_position([7, 0])
        bishop.update_possible_moves(board_clear)
        expect(bishop.possible_moves).to eq([
          [6, 1],
          [5, 2],
          [4, 3],
          [3, 4],
          [2, 5],
          [1, 6],
          [0, 7]
        ])
      end
    end

    context 'when the bishop is positioned at the bottom right corner of the board' do
      before do
        allow(bishop).to receive(:out_of_bounds?).and_return(false, false, false, false, false, false, false, true, true, true, true)
        allow(bishop).to receive(:king_or_same_color?).and_return(false, false, false, false, false, false, false)
        allow(bishop).to receive(:opponent_piece?).and_return(false, false, false, false, false, false, false)
      end

      it 'generates the correct set of valid moves' do
        bishop.update_position([7, 7])
        bishop.update_possible_moves(board_clear)
        expect(bishop.possible_moves).to eq([
          [6, 6],
          [5, 5],
          [4, 4],
          [3, 3],
          [2, 2],
          [1, 1],
          [0, 0]
        ])
      end
    end
  end
end