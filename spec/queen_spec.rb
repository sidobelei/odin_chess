require_relative '../lib/queen'

describe Queen do
  describe '#initialize' do
    context 'when a Queen object is initialized' do
      subject(:queen) { described_class.new('red', [3, 4])}

        it 'assigns a color attribute' do
          expect(queen.color).to eq('red')    
        end
  
        it 'assigns a name attribute' do
          expect(queen.name).to eq("\e[1m\e[31mQ\e[0m")
        end
  
        it 'assigns a type attribute' do
          expect(queen.type).to eq("queen")
        end
  
        it 'assigns a position attribute' do
          expect(queen.position).to eq([3, 4])
        end
    end
  end

  describe '#update_possible_moves' do
    subject(:queen) { described_class.new('red', [3, 4]) }
    let(:king1) { double('King', color: 'red', name: 'K', type: 'king', position: [0, 4]) }
    let(:queen2) { double('Queen', color: 'white', name: 'Q', type: 'queen', position: [1, 2]) }
    let(:knight1) { double('Knight', color: 'white', name: 'N', type: 'knight', position: [0, 7]) }
    let(:pawn1) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [3, 7]) }
    let(:pawn2) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [5, 6]) }
    let(:bishop1) { double('Bishop', color: 'white', name: 'B', type: 'bishop', position: [6, 4]) }
    let(:rook1) { double('Rook', color: 'white', name: 'R', type: 'rook', position: [7, 0]) }
    let(:knight2) { double('Knight', color: 'white', name: 'N', type: 'knight', position: [3, 1]) }
    let(:king2) { double('King', color: 'white', name: 'K', type: 'king', position: [7, 6]) }
    let(:rook2) { double('Rook', color: 'red', name: 'R', type: 'rook', position: [2, 3]) }
    let(:bishop2) { double('Bishop', color: 'red', name: 'B', type: 'bishop', position: [2, 4]) }
    let(:pawn3) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [2, 5]) }
    let(:pawn4) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [3, 3]) }
    let(:pawn5) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [3, 5]) }
    let(:pawn6) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [4, 3]) }
    let(:knight3) { double('Knight', color: 'red', name: 'N', type: 'knight', position: [4, 4]) }
    let(:bishop3) { double('Bishop', color: 'red', name: 'B', type: 'bishop', position: [4, 5]) }
    let(:rook3) { double('Rook', color: 'white', name: 'R', type: 'rook', position: [2, 3]) }
    let(:bishop4) { double('Bishop', color: 'white', name: 'B', type: 'bishop', position: [2, 4]) }
    let(:rook4) { double('Rook', color: 'white', name: 'R', type: 'rook', position: [2, 5]) }
    let(:pawn7) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [3, 3]) }
    let(:pawn8) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [3, 5]) }
    let(:pawn9) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [4, 3]) }
    let(:pawn10) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [4, 4]) }
    let(:pawn11) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [4, 5]) }
    let(:king_in_check) { double('King', color: 'white', name: 'K', type: 'king', position: [1, 4]) }
    let(:my_king) { double('King', color: 'red', name: 'K', type: 'king', position: [1, 4]) }

    let(:board_mixed) { [
      queen,
      king1,
      queen2,
      knight1,
      pawn1,
      pawn2,
      bishop1,
      rook1,
      knight2,
      king2
    ] }
    let(:board_boxed_in_same) { [
      queen,
      king1,
      rook2,
      bishop2,
      pawn3,
      pawn4,
      pawn5,
      pawn6,
      knight3,
      bishop3,
      king2
    ] }
    let(:board_boxed_in_opposite) { [
      queen,
      king1,
      rook3,
      bishop4,
      rook4,
      pawn7,
      pawn8,
      pawn9,
      pawn10,
      pawn11,
      king2
    ] }
    let(:board_mixed) { [
      queen,
      king1,
      queen2,
      knight1,
      pawn1,
      pawn2,
      bishop1,
      rook1,
      knight2,
      king2
    ] }
    let(:board_empty) { [
      queen
    ] }
    let(:board_in_check) { [
      queen,
      king_in_check
    ] }
    let(:board_my_king) { [
      queen,
      my_king
    ] }
    
    context 'when the board is empty' do
      it 'possible_moves has all the moves' do
        queen.update_possible_moves(board_empty)
        expect(queen.possible_moves).to eq([
          [2, 3],
          [1, 2],
          [0, 1],
          [2, 4],
          [1, 4],
          [0, 4],
          [2, 5],
          [1, 6],
          [0, 7],
          [3, 5],
          [3, 6],
          [3, 7],
          [4, 5],
          [5, 6],
          [6, 7],
          [4, 4],
          [5, 4],
          [6, 4],
          [7, 4],
          [4, 3],
          [5, 2],
          [6, 1],
          [7, 0],
          [3, 3],
          [3, 2],
          [3, 1],
          [3, 0]
        ])
      end
    end
    
    context 'when there are different chess pieces surrounding the Queen' do
      it 'possible_moves has a limited set of moves' do
        queen.update_possible_moves(board_mixed)
        expect(queen.possible_moves).to eq([
          [2, 3],
          [1, 2],
          [2, 4],
          [1, 4],
          [2, 5],
          [1, 6],
          [0, 7],
          [3, 5],
          [3, 6],
          [4, 5],
          [5, 6],
          [4, 4],
          [5, 4],
          [6, 4],
          [4, 3],
          [5, 2],
          [6, 1],
          [7, 0],
          [3, 3],
          [3, 2],
          [3, 1]
        ])
      end
    end

    context 'when there are chess pieces of the same color boxing in the Queen' do
      it 'possible_moves is an empty array' do
        queen.update_possible_moves(board_boxed_in_same)
        expect(queen.possible_moves).to eq([])
      end
    end
    
    context 'when there are chess pieces of a different color boxing in the Queen' do
      it 'possible_moves has a limited set of moves' do
        queen.update_possible_moves(board_boxed_in_opposite)
        expect(queen.possible_moves).to eq([
          [2, 3],
          [2, 4],
          [2, 5],
          [3, 5],
          [4, 5],
          [4, 4],
          [4, 3],
          [3, 3]
        ])
      end
    end

    context 'when an opponent King is in the path of the Queen' do
      it 'generates a set of moves that includes the position of the opponent King' do
        queen.update_possible_moves(board_in_check)
        expect(queen.possible_moves).to eq([
          [2, 3],
          [1, 2],
          [0, 1],
          [2, 4],
          [1, 4],
          [2, 5],
          [1, 6],
          [0, 7],
          [3, 5],
          [3, 6],
          [3, 7],
          [4, 5],
          [5, 6],
          [6, 7],
          [4, 4],
          [5, 4],
          [6, 4],
          [7, 4],
          [4, 3],
          [5, 2],
          [6, 1],
          [7, 0],
          [3, 3],
          [3, 2],
          [3, 1],
          [3, 0]
        ])          
      end  
    end

    context 'when your King is in the path of your Queen' do
      it 'generates a set of moves that excludes ' do
        queen.update_possible_moves(board_my_king)
        expect(queen.possible_moves).to eq([
          [2, 3],
          [1, 2],
          [0, 1],
          [2, 4],
          [2, 5],
          [1, 6],
          [0, 7],
          [3, 5],
          [3, 6],
          [3, 7],
          [4, 5],
          [5, 6],
          [6, 7],
          [4, 4],
          [5, 4],
          [6, 4],
          [7, 4],
          [4, 3],
          [5, 2],
          [6, 1],
          [7, 0],
          [3, 3],
          [3, 2],
          [3, 1],
          [3, 0]
        ])
      end
    end

    context 'when the Queen is at the top of the board' do
      it 'generates the correct set of valid moves' do
        queen.update_position([0, 3])
        queen.update_possible_moves(board_empty)
        expect(queen.possible_moves).to eq([
          [0, 4],
          [0, 5],
          [0, 6],
          [0, 7],
          [1, 4],
          [2, 5],
          [3, 6],
          [4, 7],
          [1, 3],
          [2, 3],
          [3, 3],
          [4, 3],
          [5, 3],
          [6, 3],
          [7, 3],
          [1, 2],
          [2, 1],
          [3, 0],
          [0, 2],
          [0, 1],
          [0, 0]
        ])
      end
    end

    context 'when the Queen is the bottom of the board' do
      it 'generates the correct set of valid moves' do
        queen.update_position([7, 4])
        queen.update_possible_moves(board_empty)
        expect(queen.possible_moves).to eq([
          [6, 3],
          [5, 2],
          [4, 1],
          [3, 0],
          [6, 4],
          [5, 4],
          [4, 4],
          [3, 4],
          [2, 4],
          [1, 4],
          [0, 4],
          [6, 5],
          [5, 6],
          [4, 7],
          [7, 5],
          [7, 6],
          [7, 7],
          [7, 3],
          [7, 2],
          [7, 1],
          [7, 0]
        ])
      end
    end

    context 'when the Queen is at the left edge of the board' do
      it 'generates the correct set of valid moves' do
        queen.update_position([3, 0])
        queen.update_possible_moves(board_empty)
        expect(queen.possible_moves).to eq([
          [2, 0],
          [1, 0],
          [0, 0],
          [2, 1],
          [1, 2],
          [0, 3],
          [3, 1],
          [3, 2],
          [3, 3],
          [3, 4],
          [3, 5],
          [3, 6],
          [3, 7],
          [4, 1],
          [5, 2],
          [6, 3],
          [7, 4],
          [4, 0],
          [5, 0],
          [6, 0],
          [7, 0]
        ])
      end
    end

    context 'when the Queen is at the right edge of the board' do
      it 'generates the correct set of valid moves' do
        queen.update_position([4, 7])
        queen.update_possible_moves(board_empty)
        expect(queen.possible_moves).to eq([
          [3, 6],
          [2, 5],
          [1, 4],
          [0, 3],
          [3, 7],
          [2, 7],
          [1, 7],
          [0, 7],
          [5, 7],
          [6, 7],
          [7, 7],
          [5, 6],
          [6, 5],
          [7, 4],
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

    context 'when the Queen is at the top left corner of the board' do
      it 'generates the correct set of valid moves' do
        queen.update_position([0, 0])
        queen.update_possible_moves(board_empty)
        expect(queen.possible_moves).to eq([
          [0, 1],
          [0, 2],
          [0, 3],
          [0, 4],
          [0, 5],
          [0, 6],
          [0, 7],
          [1, 1],
          [2, 2],
          [3, 3],
          [4, 4],
          [5, 5],
          [6, 6],
          [7, 7],
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

    context 'when the Queen is at the top right corner of the board' do
      it 'generates the correct set of valid moves' do
        queen.update_position([0, 7])
        queen.update_possible_moves(board_empty)
        expect(queen.possible_moves).to eq([
          [1, 7],
          [2, 7],
          [3, 7],
          [4, 7],
          [5, 7],
          [6, 7],
          [7, 7],
          [1, 6],
          [2, 5],
          [3, 4],
          [4, 3],
          [5, 2],
          [6, 1],
          [7, 0],
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

    context 'when the Queen is at the bottom left corner of the board' do
      it 'generates the correct set of valid moves' do
        queen.update_position([7, 0])
        queen.update_possible_moves(board_empty)
        expect(queen.possible_moves).to eq([
          [6, 0],
          [5, 0],
          [4, 0],
          [3, 0],
          [2, 0],
          [1, 0],
          [0, 0],
          [6, 1],
          [5, 2],
          [4, 3],
          [3, 4],
          [2, 5],
          [1, 6],
          [0, 7],
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

    context 'when the Queen is at the bottom right corner of the board' do
      it 'generates the correct set of valid moves' do
        queen.update_position([7, 7])
        queen.update_possible_moves(board_empty)
        expect(queen.possible_moves).to eq([
          [6, 6],
          [5, 5],
          [4, 4],
          [3, 3],
          [2, 2],
          [1, 1],
          [0, 0],
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
  end
end