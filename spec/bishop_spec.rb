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
  end
end