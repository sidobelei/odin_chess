require_relative '../lib/rook'

describe Rook do
  describe '#initialize' do
    context 'when a Rook object is initialized' do
      subject(:rook) { described_class.new('red', [3, 4]) }
      it 'assigns a color attribute' do
        expect(rook.color).to eq('red')    
      end

      it 'assigns a name attribute' do
        expect(rook.name).to eq("\e[1m\e[31mR\e[0m")
      end

      it 'assigns a type attribute' do
        expect(rook.type).to eq("rook")
      end

      it 'assigns a position attribute' do
        expect(rook.position).to eq([3, 4])
      end
      
      it 'assigns zero to the moved attribute' do
        expect(rook.moved).to eq(0)
      end
    end
  end

  describe '#update_position' do
    context 'when the Rook was not moved and is called to be moved' do
      subject(:rook_unmoved) { described_class.new('white', [7, 0]) }
      
      it 'updates the current position and changes the moved attribute to one' do
        rook_unmoved.update_position([5, 0])
        expect(rook_unmoved.position).to eq([5, 0])
        expect(rook_unmoved.moved).to eq(1)
      end
    end

    context 'when the Rook was moved previously and is called to be moved again' do
      subject(:rook_moved) { described_class.new('red', [0, 7]) }
      
      it 'updates the current position and moved attribute increases by two' do
        expect(rook_moved.moved).to eq(0)
        rook_moved.update_position([0, 6])
        expect(rook_moved.moved).to eq(1)
        rook_moved.update_position([4, 6])
        expect(rook_moved.position).to eq([4, 6])
        expect(rook_moved.moved).to eq(2)
      end
    end
  end

  describe '#update_possible_moves' do
    subject(:rook) { described_class.new('red', [3, 4]) }
    let(:king1) { double('King', color: 'red', name: 'K', type: 'king', position: [1, 4]) } 
    let(:knight1) { double('Knight', color: 'white', name: 'N', type: 'knight', position: [3, 6]) }
    let(:pawn1) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [6, 4]) }
    let(:bishop1) { double('Bishop', color: 'red', name: 'B', type: 'bishop', position: [3, 2]) }
    let(:king2) { double('King', color: 'white', name: 'K', type: 'king', position: [7, 7]) } 
    let(:rook2) { double('Rook', color: 'white', name: 'R', type: 'rook', position: [2, 3]) }
    let(:knight2) { double('Knight', color: 'white', name: 'N', type: 'knight', position: [2, 5]) }
    let(:queen1) { double('Queen', color: 'white', name: 'Q', type: 'queen', position: [2, 4]) }
    let(:bishop2) { double('Bishop', color: 'white', name: 'B', type: 'bishop', position: [3, 3]) }
    let(:pawn2) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [3, 5]) }
    let(:pawn3) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [4, 3]) }
    let(:pawn4) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [4, 4]) }
    let(:pawn5) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [4, 5]) }
    let(:rook2) { double('Rook', color: 'red', name: 'R', type: 'rook', position: [2, 3]) }
    let(:knight3) { double('Knight', color: 'red', name: 'N', type: 'knight', position: [2, 5]) }
    let(:queen2) { double('Queen', color: 'red', name: 'Q', type: 'queen', position: [2, 4]) }
    let(:bishop3) { double('Bishop', color: 'red', name: 'B', type: 'bishop', position: [3, 3]) }
    let(:pawn6) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [3, 5]) }
    let(:pawn7) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [4, 3]) }
    let(:pawn8) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [4, 4]) }
    let(:pawn9) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [4, 5]) }
    let(:in_check_king) { double('King', color: 'white', name: 'K', type: 'king', position: [1, 4]) }
    let(:my_king) { double('King', color: 'red', name: 'K', type: 'king', position: [0, 1]) } 
    let(:bishop4) { double('Bishop', color: 'white', name: 'B', type: 'bishop', position: [4, 1]) }

    let(:board_empty) {[
      rook,
      king1
    ]}
    let(:board_mixed) { [
      rook,
      king1,
      knight1,
      pawn1,
      bishop1,
      king2
    ] }
    let(:board_boxed_in_opposite) { [
      rook,
      knight2,
      queen1,
      bishop2,
      pawn2,
      pawn3,
      pawn4,
      pawn5,
      my_king
    ] }
    let(:board_boxed_in_same) { [
      rook2,
      knight3,
      queen2,
      bishop3,
      pawn6,
      pawn7,
      pawn8,
      pawn9
    ] }
    let(:board_in_check) { [
      rook,
      in_check_king,
      my_king
    ] }
    let(:board_my_king) { [
      rook,
      king1
    ] }
    let(:board_cancel_check) { [
      rook,
      king1,
      bishop4
    ] }

    context 'when the board is empty' do
      it 'possible_moves has all moves' do
        rook.update_position([3, 5])
        rook.update_possible_moves(board_empty)
        expect(rook.possible_moves).to eq([
          [2, 5],
          [1, 5],
          [0, 5],
          [3, 6],
          [3, 7],
          [4, 5],
          [5, 5],
          [6, 5],
          [7, 5],
          [3, 4],
          [3, 3],
          [3, 2],
          [3, 1],
          [3, 0]
        ])
      end
    end

    context 'when the board is surrounded by different chess pieces' do #fix wording
      it 'possible_moves has a limited set of moves' do
        rook.update_possible_moves(board_mixed)
        expect(rook.possible_moves).to eq([
          [2, 4],
          [3, 5],
          [3, 6],
          [4, 4],
          [5, 4],
          [6, 4],
          [3, 3]
        ])
      end
    end

    context 'when there are chess pieces of the same color boxing in the Rook' do
      it 'possible_moves is an empty array' do
        rook.update_position(board_boxed_in_same)
        expect(rook.possible_moves).to eq([])
      end
    end

    context 'when there are chess pieces of the different color boxing in the Rook' do
      it 'possible_moves has a limited set of moves' do
        rook.update_possible_moves(board_boxed_in_opposite)
        expect(rook.possible_moves).to eq([
          [2, 4],
          [3, 5],
          [4, 4],
          [3, 3]
        ])
      end
    end

    context 'when the opponent King is in the path of the Rook' do
      it 'generates a set of moves the position of the opponent King' do
        rook.update_possible_moves(board_in_check)
        expect(rook.possible_moves).to eq([
          [2, 4],
          [1, 4],
          [3, 5],
          [3, 6],
          [3, 7],
          [4, 4],
          [5, 4],
          [6, 4],
          [7, 4],
          [3, 3],
          [3, 2],
          [3, 1],
          [3, 0]
        ])          
      end  
    end

    context 'when your own King is in the path of the Rook' do
      it 'generates a set of moves that excludes the position of your King' do
        rook.update_possible_moves(board_my_king)
        expect(rook.possible_moves).to eq([
          [2, 4],
          [3, 5],
          [3, 6],
          [3, 7],
          [4, 4],
          [5, 4],
          [6, 4],
          [7, 4],
          [3, 3],
          [3, 2],
          [3, 1],
          [3, 0]
        ])
      end
    end

    context 'when the Rook is at the top of the board' do
      it 'generates the correct set of valid moves' do
        rook.update_position([0, 3])
        rook.update_possible_moves(board_empty)
        expect(rook.possible_moves).to eq([
          [0, 4],
          [0, 5],
          [0, 6],
          [0, 7],
          [1, 3],
          [2, 3],
          [3, 3],
          [4, 3],
          [5, 3],
          [6, 3],
          [7, 3],
          [0, 2],
          [0, 1],
          [0, 0]
        ])
      end
    end

    context 'when the Rook is at the bottom of the board' do
      it 'generates the correct set of valid moves' do
        rook.update_position([7, 5])
        rook.update_possible_moves(board_empty)
        expect(rook.possible_moves).to eq([
          [6, 5],
          [5, 5],
          [4, 5],
          [3, 5],
          [2, 5],
          [1, 5],
          [0, 5],
          [7, 6],
          [7, 7],
          [7, 4],
          [7, 3],
          [7, 2],
          [7, 1],
          [7, 0]
        ])
      end
    end

    context 'when the Rook is at the left edge of the board' do
      it 'generates the correct set of valid moves' do
        rook.update_position([3, 0])
        rook.update_possible_moves(board_empty)
        expect(rook.possible_moves).to eq([
          [2, 0],
          [1, 0],
          [0, 0],
          [3, 1],
          [3, 2],
          [3, 3],
          [3, 4],
          [3, 5],
          [3, 6],
          [3, 7],
          [4, 0],
          [5, 0],
          [6, 0],
          [7, 0]
        ])
      end
    end

    context 'when the Rook is at the right edge of the board' do
      it 'generates the correct set of valid moves' do
        rook.update_position([4, 7])
        rook.update_possible_moves(board_empty)
        expect(rook.possible_moves).to eq([
          [3, 7],
          [2, 7],
          [1, 7],
          [0, 7],
          [5, 7],
          [6, 7],
          [7, 7],
          [4, 6],
          [4, 5],
          [4, 4],
          [4, 3],
          [4, 2],
          [4, 1],
          [4, 0]
        ])
      end
    end

    context 'when the Rook is at the top left corner of the board' do
      it 'generates the correct set of valid moves' do
        rook.update_position([0, 0])
        rook.update_possible_moves(board_empty)
        expect(rook.possible_moves).to eq([
          [0, 1],
          [0, 2],
          [0, 3],
          [0, 4],
          [0, 5],
          [0, 6],
          [0, 7],
          [1, 0],
          [2, 0],
          [3, 0],
          [4, 0],
          [5, 0],
          [6, 0],
          [7, 0]
        ])
      end
    end

    context 'when the Rook is at the top right corner of the board' do
      it 'generates the correct set of valid moves' do
        rook.update_position([0, 7])
        rook.update_possible_moves(board_empty)
        expect(rook.possible_moves).to eq([
          [1, 7],
          [2, 7],
          [3, 7],
          [4, 7],
          [5, 7],
          [6, 7],
          [7, 7],
          [0, 6],
          [0, 5],
          [0, 4],
          [0, 3],
          [0, 2],
          [0, 1],
          [0, 0]
        ])
      end
    end

    context 'when the Rook is at the bottom left corner of the board' do
      it 'generates the correct set of valid moves' do
        rook.update_position([7, 0])
        rook.update_possible_moves(board_empty)
        expect(rook.possible_moves).to eq([
          [6, 0],
          [5, 0],
          [4, 0],
          [3, 0],
          [2, 0],
          [1, 0],
          [0, 0],
          [7, 1],
          [7, 2],
          [7, 3],
          [7, 4],
          [7, 5],
          [7, 6],
          [7, 7]
        ])     
      end
    end

    context 'when the Rook is at the bottom right corner of the board' do
      it 'generates the correct set of valid moves' do
        rook.update_position([7, 7])
        rook.update_possible_moves(board_empty)
        expect(rook.possible_moves).to eq([
          [6, 7],
          [5, 7],
          [4, 7],
          [3, 7],
          [2, 7],
          [1, 7],
          [0, 7],
          [7, 6],
          [7, 5],
          [7, 4],
          [7, 3],
          [7, 2],
          [7, 1],
          [7, 0]
        ])     
      end
    end

    context "when the Rook cannot move because it would place its King in check" do
      it "generates no moves" do
        rook.update_position([2, 3])
        rook.update_possible_moves(board_cancel_check)
        expect(rook.possible_moves).to eq([])
      end
    end

    context "when the Rook's only move is to capture the opposing piece that is causing a check" do
      it "generates only the move to capture the opposing piece causing the check" do
        rook.update_position([7, 1])
        rook.update_possible_moves(board_cancel_check)
        expect(rook.possible_moves).to eq([[4, 1]])
      end
    end

    context "when the Rook's only move is to block the opposing piece's check" do
      it "generates only the move that will block the opposing piece's check" do
        rook.update_position([3, 7])
        rook.update_possible_moves(board_cancel_check)
        expect(rook.possible_moves).to eq([[3, 2]])
      end
    end
  end
end