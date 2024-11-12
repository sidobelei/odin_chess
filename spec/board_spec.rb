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
    
  end
end