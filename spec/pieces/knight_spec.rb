require_relative '../../lib/pieces/knight'

describe Knight do
  describe '#initialize' do
    subject(:knight) { described_class.new('white', [0, 6]) }

    context 'when a Knight object is initialized' do
      it 'assigns a color attribute' do
        expect(knight.color).to eq('white') 
      end

      it 'assigns a name attribute' do
        expect(knight.name).to eq("\e[1m\e[37mN\e[0m")
      end

      it 'assigns a type attribute' do
        expect(knight.type).to eq('knight')
      end

      it 'assigns a position attribute' do
        expect(knight.position).to eq([0, 6])
      end
    end
  end

  describe '#update_possible_moves' do
    subject(:knight) { described_class.new('red', [4, 4]) }
    
    let(:king1) { double('King', color: 'white', name: 'K', type: 'king', position:[7, 6]) }
    let(:bishop1) { double('Bishop', color: 'white', name: 'B', type: 'bishop', position: [2, 5]) }
    let(:knight1) { double('Knight', color: 'white', name: 'N', type: 'knight', position: [3, 6]) }
    let(:pawn1) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [5, 6]) }
    let(:pawn2) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [6, 5]) }
    let(:rook1) { double('Rook', color: 'white', name: 'R', type: 'rook', position: [6, 3]) }
    let(:queen1) { double('Queen', color: 'white', name: 'Q', type: 'queen', position: [5, 2]) }
    let(:pawn3) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [3, 2]) }
    let(:pawn4) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [2, 3]) }
    let(:king2) { double('King', color: 'red', name: 'K', type: 'king', position:[0, 2]) }
    let(:bishop2) { double('Bishop', color: 'red', name: 'B', type: 'bishop', position: [2, 5]) }
    let(:knight2) { double('Knight', color: 'red', name: 'N', type: 'knight', position: [3, 6]) }
    let(:pawn5) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [5, 6]) }
    let(:pawn6) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [6, 5]) }
    let(:rook2) { double('Rook', color: 'red', name: 'R', type: 'rook', position: [6, 3]) }
    let(:queen2) { double('Queen', color: 'red', name: 'Q', type: 'queen', position: [5, 2]) }
    let(:pawn7) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [3, 2]) }
    let(:pawn8) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [2, 3]) }
    let(:pawn9) { double('Pawn', color:'white', name: 'P', type: 'pawn', position:[3, 3]) }
    let(:pawn10) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [3, 4]) }
    let(:pawn11) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [3, 5]) }
    let(:bishop3) { double('Bishop', color: 'white', name: 'B', type: 'bishop', position: [4, 3]) }
    let(:bishop4) { double('Bishop', color: 'red', name: 'B', type: 'bishop', position: [4, 5]) }
    let(:pawn12) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [5, 3]) }
    let(:pawn13) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [5, 4]) }
    let(:pawn14) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [5, 5]) }
    let(:rook3) { double('Rook', color: 'red', name: 'R', type: 'rook', position: [2, 4]) }
    let(:rook4) { double('Rook', color: 'white', name: 'R', type: 'rook', position: [4, 6]) }
    let(:knight3) { double('Knight', color: 'white', name: 'N', type: 'knight', position: [6, 4]) }
    let(:knight4) { double('Knight', color: 'red', name: 'N', type: 'knight', position: [4, 2]) }
    let(:king_in_check) { double('King', color: 'white', name: 'K', type: 'king', position: [5, 2]) }
    let(:my_king) { double('King', color: 'red', name: 'K', type: 'king', position: [5, 0]) }
    let(:rook5) { double('Rook', color: 'white', name: 'R', type: 'rook', position: [5, 4]) }

    let(:board_empty) { [
      knight,
      king1,
      king2
    ] }
    let(:board_border_white) { [
      knight,
      king1,
      bishop1,
      knight1,
      pawn1,
      pawn2,
      rook1,
      queen1,
      pawn3,
      pawn4,
      king2 
    ] }
    let(:board_border_red) { [
      knight,
      king1,
      bishop2,
      knight2,
      pawn5,
      pawn6,
      rook2,
      queen2,
      pawn7,
      pawn8,
      king2 
    ] }
    let(:board_mixed) { [
      knight,
      king1, 
      bishop1,
      knight2, 
      pawn1,
      pawn6,
      rook1,
      queen2,
      pawn3,
      pawn8,
      king2,
      pawn9,
      pawn10,
      bishop2,
      pawn12,
      pawn14,
      rook3,
      knight3
    ] }
    let(:board_surrounded_white) { [
      knight,
      king1,
      bishop1,
      knight1,
      pawn1,
      pawn2,
      rook1,
      queen1,
      pawn3,
      pawn4,
      king2,
      pawn9,
      pawn10,
      pawn11,
      bishop3,
      bishop4,
      pawn12,
      pawn13,
      pawn14,
      rook3,
      rook4,
      knight3,
      knight4
    ] }
    let(:board_surrounded_red) { [
      knight,
      king1,
      bishop2,
      knight2,
      pawn5,
      pawn6,
      rook2,
      queen2,
      pawn7,
      pawn8,
      king2,
      pawn9,
      pawn10,
      pawn11,
      bishop2,
      bishop3,
      pawn12,
      pawn13,
      pawn14,
      rook3,
      rook4,
      knight3,
      knight4
    ] }
    let(:board_boxed_in) { [
      knight,
      king1,
      king2,
      pawn9,
      pawn10,
      pawn11,
      bishop3,
      bishop4,
      pawn12,
      pawn13,
      pawn14,
      rook3,
      rook4,
      knight3,
      knight4
    ] }
    let(:board_in_check) { [
      knight,
      king_in_check,
      my_king
    ] }
    let(:board_my_king) { [
      knight,
      my_king
    ] }
    let(:board_cancel_check) { [
      knight,
      my_king,
      rook5
    ] }

    context 'when there are no game pieces in the path of the knight piece and no game pieces at its final position' do
      it 'possible_moves has all moves' do
        knight.update_possible_moves(board_empty)
        expect(knight.possible_moves).to eq([
          [2, 3],
          [2, 5],
          [3, 6],
          [5, 6],
          [6, 5],
          [6, 3],
          [5, 2],
          [3, 2]
        ])
      end
    end

    context 'when there are game pieces in the path of the knight piece and there no chess pieces at its final position' do
      it 'possible_moves has all moves' do
        knight.update_possible_moves(board_boxed_in)
        expect(knight.possible_moves).to eq([
          [2, 3],
          [2, 5],
          [3, 6],
          [5, 6],
          [6, 5],
          [6, 3],
          [5, 2],
          [3, 2]
        ])
      end
    end

    context 'when there are no game pieces in the path of the knight piece and there are chess pieces of a different color at its final position' do
      it 'possible_moves has all moves' do
        knight.update_possible_moves(board_border_white)
        expect(knight.possible_moves).to eq([
          [2, 3],
          [2, 5],
          [3, 6],
          [5, 6],
          [6, 5],
          [6, 3],
          [5, 2],
          [3, 2]
        ])
      end
    end

    context 'when there are no game pieces in the path of the knight piece and there are chess pieces of the same color at its final position' do
      it 'possible_moves is empty' do
        knight.update_possible_moves(board_border_red)
        expect(knight.possible_moves).to eq([])
      end
    end

    context 'when there are game pieces in the path of the knight piece and there are chess pieces of a different color at its final position' do
      it 'possible_moves has all moves' do
        knight.update_possible_moves(board_surrounded_white)
        expect(knight.possible_moves).to eq([
          [2, 3],
          [2, 5],
          [3, 6],
          [5, 6],
          [6, 5],
          [6, 3],
          [5, 2],
          [3, 2]
        ])
      end
    end

    context 'when there are game pieces in the path of the knight piece and there are chess pieces of the same color are its final position' do
      it 'possible_moves is empty' do
        knight.update_possible_moves(board_surrounded_red)
        expect(knight.possible_moves).to eq([])
      end
    end

    context 'when there are game pieces in the path of the knight piece and there are a few different chess pieces at its final position' do
      it 'generates the correct set of moves' do
        knight.update_possible_moves(board_mixed)
        expect(knight.possible_moves).to eq([
          [5, 6],
          [6, 3],
          [3, 2]
        ])
      end
    end

    context 'when the opponent King is in the path of the Knight' do
      it 'generates a set of moves that excludes the position of the opponent King' do
        knight.update_possible_moves(board_in_check)
        expect(knight.possible_moves).to eq([
          [2, 3],
          [2, 5],
          [3, 6],
          [5, 6],
          [6, 5],
          [6, 3],
          [3, 2]
        ])
      end
    end

    context 'when your Knight is in the path of your King' do
      it 'generates a set of moves that excludes the position of your King' do
        knight.update_position([4, 2])
        knight.update_possible_moves(board_my_king)
        expect(knight.possible_moves).to eq([
          [2, 1],
          [2, 3],
          [3, 4],
          [5, 4],
          [6, 3],
          [6, 1],
          [3, 0]
        ])
      end
    end

    context 'when the knight is positioned at the top of the board' do
      it 'generates the correct set of moves' do
        knight.update_position([0, 3])
        knight.update_possible_moves(board_empty)
        expect(knight.possible_moves).to eq([
          [1, 5],
          [2, 4],
          [2, 2],
          [1, 1]
        ])
      end
    end

    context 'when the knight is positioned on the left edge of the board' do
      it 'generates the correct set of moves' do
        knight.update_position([3, 0])
        knight.update_possible_moves(board_empty)
        expect(knight.possible_moves).to eq([
          [1, 1],
          [2, 2],
          [4, 2],
          [5, 1]
        ])
      end
    end

    context 'when the knight is positioned on the right edge of the board' do
      it 'generates the correct set of moves' do
        knight.update_position([4, 7])
        knight.update_possible_moves(board_empty)
        expect(knight.possible_moves).to eq([
          [2, 6],
          [6, 6],
          [5, 5],
          [3, 5]
        ])
      end
    end

    context 'when the knight is positioned at the bottom of the board' do
      it 'generates the correct set of moves' do
        knight.update_position([7, 4])
        knight.update_possible_moves(board_empty)
        expect(knight.possible_moves).to eq([
          [5, 3],
          [5, 5],
          [6, 6],
          [6, 2]
        ])
      end
    end

    context 'when the knight is positioned at the top left corner of the board' do
      it 'generates the correct set of moves' do
        knight.update_position([0, 0])
        knight.update_possible_moves(board_empty)
        expect(knight.possible_moves).to eq([
          [1, 2],
          [2, 1]
        ])
      end
    end

    context 'when the knight is positioned at the top right corner of the board' do
      it 'generates the correct set of moves' do
        knight.update_position([0, 7])
        knight.update_possible_moves(board_empty)
        expect(knight.possible_moves).to eq([
          [2, 6],
          [1, 5]
        ])
      end
    end

    context 'when the knight is positioned at the bottom left corner of the board' do
      it 'generates the correct set of moves' do
        knight.update_position([7, 0])
        knight.update_possible_moves(board_empty)
        expect(knight.possible_moves).to eq([
          [5, 1],
          [6, 2],
        ])
      end
    end

    context 'when the knight is positioned at the bottom right corner of the board' do
      it 'generates the correct set of moves' do
        knight.update_position([7, 7])
        knight.update_possible_moves(board_empty)
        expect(knight.possible_moves).to eq([
          [5, 6],
          [6, 5]
        ])
      end
    end

    context "when the Knight cannot move because it would place its King in check" do
      it "generates no moves" do
        knight.update_position([5, 2])
        knight.update_possible_moves(board_cancel_check)
        expect(knight.possible_moves).to eq([])
      end
    end

    context "when the Knight's only move is to capture the opposing piece that is causing a check" do
      it "generates only the move to capture the opposing piece causing the check" do
        knight.update_position([3, 5])
        knight.update_possible_moves(board_cancel_check)
        expect(knight.possible_moves).to eq([[5, 4]])
      end
    end

    context "when the Knight's only move is to block the opposing piece's check" do
      it "generates only the move that will block the opposing piece's check" do
        knight.update_position([3, 1])
        knight.update_possible_moves(board_cancel_check)
        expect(knight.possible_moves).to eq([[5, 2]])
      end
    end
  end
end