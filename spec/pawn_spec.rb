require_relative '../lib/pawn'

describe Pawn do
  describe '#initialize' do
    subject(:pawn) { described_class.new('white', [4, 4]) }
    
    context 'when a Pawn object is initialized' do
      it 'assigns a color attribute' do
        expect(pawn.color).to eq('white')
      end
      
      it 'assigns a name attribute' do
        expect(pawn.name).to eq("\e[1m\e[37mP\e[0m")
      end
      
      it 'assigns a type attribute' do
        expect(pawn.type).to eq('pawn')
      end
      
      it 'assigns a position attribute' do
        expect(pawn.position).to eq([4, 4])
      end
      
      it 'assigns zero to the moved attribute' do
        expect(pawn.moved).to eq(0)
      end
      
      it 'assigns false to the promoted attribute' do
        expect(pawn.promoted).to eq(false)
      end
    end
  end

  describe '#update_position' do
    subject(:default_pawn) { described_class.new('red', [2, 7]) }
    subject(:moved_pawn) { described_class.new('white', [4, 4]) }
    subject(:white_pawn1) { described_class.new('white', [1, 0]) }
    subject(:white_pawn2) { described_class.new('white', [1, 1]) }
    subject(:white_pawn3) { described_class.new('white', [1, 2]) }
    subject(:white_pawn4) { described_class.new('white', [1, 3]) }
    subject(:white_pawn5) { described_class.new('white', [1, 4]) }
    subject(:white_pawn6) { described_class.new('white', [1, 5]) }
    subject(:white_pawn7) { described_class.new('white', [1, 6]) }
    subject(:white_pawn8) { described_class.new('white', [1, 7]) }
    subject(:red_pawn1) { described_class.new('red', [6, 0]) }
    subject(:red_pawn2) { described_class.new('red', [6, 1]) }
    subject(:red_pawn3) { described_class.new('red', [6, 2]) }
    subject(:red_pawn4) { described_class.new('red', [6, 3]) }
    subject(:red_pawn5) { described_class.new('red', [6, 4]) }
    subject(:red_pawn6) { described_class.new('red', [6, 5]) }
    subject(:red_pawn7) { described_class.new('red', [6, 6]) }
    subject(:red_pawn8) { described_class.new('red', [6, 7]) }

    context 'when the Pawn has not reached the other end of the board and has not been moved' do
      it 'updates its current position and changes moved attribute to one' do
        expect(default_pawn.position).to eq([2, 7])
        expect(default_pawn.moved).to eq(0)
        default_pawn.update_position([4, 7])
        expect(default_pawn.position).to eq([4, 7])
        expect(default_pawn.moved).to eq(1)
      end
    
    end
    
    context 'when the Pawn has not reached the other end of the board and has moved' do
      it 'updates its current position and the moved attribute is not zero' do
        expect(moved_pawn.position).to eq([4, 4])
        moved_pawn.update_position([5, 4])
        expect(moved_pawn.position).to eq([5, 4])
      end
    end

    context 'when the Pawn has reached the other end of the board' do
      it 'updates its position to nil and changes the promoted attribute to true' do
        white_pawn1.update_position([0, 0])
        white_pawn2.update_position([0, 1])
        white_pawn3.update_position([0, 2])
        white_pawn4.update_position([0, 3])
        white_pawn5.update_position([0, 4])
        white_pawn6.update_position([0, 5])
        white_pawn7.update_position([0, 6])
        white_pawn8.update_position([0, 7])
        red_pawn1.update_position([7, 0])
        red_pawn2.update_position([7, 1])
        red_pawn3.update_position([7, 2])
        red_pawn4.update_position([7, 3])
        red_pawn5.update_position([7, 4])
        red_pawn6.update_position([7, 5])
        red_pawn7.update_position([7, 6])
        red_pawn8.update_position([7, 7])
        expect(white_pawn1.position).to eq(nil)
        expect(white_pawn1.promoted).to eq(true)
        expect(white_pawn2.position).to eq(nil)
        expect(white_pawn2.promoted).to eq(true)
        expect(white_pawn3.position).to eq(nil)
        expect(white_pawn3.promoted).to eq(true)
        expect(white_pawn4.position).to eq(nil)
        expect(white_pawn4.promoted).to eq(true)
        expect(white_pawn5.position).to eq(nil)
        expect(white_pawn5.promoted).to eq(true)
        expect(white_pawn6.position).to eq(nil)
        expect(white_pawn6.promoted).to eq(true)
        expect(white_pawn7.position).to eq(nil)
        expect(white_pawn7.promoted).to eq(true)
        expect(white_pawn8.position).to eq(nil)
        expect(white_pawn8.promoted).to eq(true)
        expect(red_pawn1.position).to eq(nil)
        expect(red_pawn1.promoted).to eq(true)
        expect(red_pawn2.position).to eq(nil)
        expect(red_pawn2.promoted).to eq(true)
        expect(red_pawn3.position).to eq(nil)
        expect(red_pawn3.promoted).to eq(true)
        expect(red_pawn4.position).to eq(nil)
        expect(red_pawn4.promoted).to eq(true)
        expect(red_pawn5.position).to eq(nil)
        expect(red_pawn5.promoted).to eq(true)
        expect(red_pawn6.position).to eq(nil)
        expect(red_pawn6.promoted).to eq(true)
        expect(red_pawn7.position).to eq(nil)
        expect(red_pawn7.promoted).to eq(true)
        expect(red_pawn8.position).to eq(nil)
        expect(red_pawn8.promoted).to eq(true)
      end
    end
  end

  describe '#update_possible_moves' do
    subject(:moved_pawn_white) { described_class.new('white', [5, 6]) }
    subject(:moved_pawn_red) { described_class.new('red', [1, 2]) }
    subject(:unmoved_pawn_white) { described_class.new('white', [6, 1]) }
    subject(:unmoved_pawn_red) { described_class.new('red', [1, 5]) }
    subject(:moved_pawn_white_edge) { described_class.new('white', [6, 7]) }
    subject(:moved_pawn_red_edge) { described_class.new('red', [1, 0]) }
    let(:knight1) { double('Knight', color: 'red', name: 'N', type: 'knight', position: [3, 5]) }
    let(:pawn1) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [3, 6]) }
    let(:pawn2) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [3, 7]) }
    let(:bishop1) { double('Bishop', color: 'red', name: 'B', type: 'bishop', position: [4, 5]) }
    let(:bishop2) { double('Bishop', color: 'red', name: 'B', type: 'bishop', position: [5, 5]) }
    let(:rook1) { double('Rook', color: 'red', name: 'R', type: 'rook', position: [4, 7]) }
    let(:rook2) { double('Rook', color: 'red', name: 'R', type: 'rook', position: [5, 6]) }
    let(:queen1) { double('Queen', color: 'red', name: 'Q', type: 'queen', position: [5, 7]) }
    let(:knight2) { double('Knight', color: 'white', name: 'N', type: 'knight', position: [4, 0]) }
    let(:pawn3) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [4, 1]) }
    let(:pawn4) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [4, 2]) }
    let(:bishop3) { double('Bishop', color: 'white', name: 'B', type: 'bishop', position: [3, 0]) }
    let(:bishop4) { double('Bishop', color: 'white', name: 'B', type: 'bishop', position: [2, 0]) }
    let(:rook3) { double('Rook', color: 'white', name: 'R', type: 'rook', position: [3, 2]) }
    let(:rook4) { double('Rook', color: 'white', name: 'R', type: 'rook', position: [2, 1]) }
    let(:queen2) { double('Queen', color: 'white', name: 'Q', type: 'queen', position: [2, 2]) }
    let(:king1) { double('King', color: 'white', name: 'K', type: 'king', position: [4, 1]) }
    let(:king2) { double('King', color: 'red', name: 'K', type: 'king', position: [3, 5]) }
    let(:knight3) { double('Knight', color: 'white', name: 'N', type: 'knight', position: [2, 5]) }
    let(:knight4) { double('Knight', color: 'red', name: 'N', type: 'knight', position: [5, 1]) }
    
    let(:board_boxed_in_opposite) { [
      moved_pawn_white,
      knight1,
      pawn1,
      pawn2,
      bishop1,
      bishop2,
      rook1,
      rook2,
      queen1,
      moved_pawn_red,
      knight2,
      pawn3,
      pawn4,
      bishop3,
      bishop4,
      rook3,
      rook4,
      queen2
    ] }

    let(:board_boxed_in_same) { [
      moved_pawn_white,
      knight1,
      pawn1,
      pawn2,
      bishop1,
      bishop2,
      rook1,
      rook2,
      queen1,
      moved_pawn_red,
      knight2,
      pawn3,
      pawn4,
      bishop3,
      bishop4,
      rook3,
      rook4,
      queen2
    ] }

    let(:board_empty) { [
      moved_pawn_white,
      moved_pawn_red,
      unmoved_pawn_white,
      unmoved_pawn_red
    ] }

    let(:board_diagonals) { [
      moved_pawn_white,
      knight1,
      pawn2,
      moved_pawn_red,
      knight2,
      pawn4
    ] }

    let(:board_block_forward_1) { [
      unmoved_pawn_white,
      knight3,
      unmoved_pawn_red,
      knight4
    ] }
    
    let(:board_block_forward_2) { [
      unmoved_pawn_white,
      king1,
      unmoved_pawn_red,
      king2
    ] }

    let(:board_edges) { [
      moved_pawn_white_edge,
      moved_pawn_red_edge
    ] }
    
    context 'when the Pawn was moved and is surrounded by chess pieces that are of a different color' do
      before do
        allow(moved_pawn_white).to receive(:opponent_piece?).and_return(true, false, true, true)
        allow(moved_pawn_white).to receive(:out_of_bounds?).and_return(false)
        allow(moved_pawn_white).to receive(:king_or_same_color?).and_return(false)
        allow(moved_pawn_red).to receive(:opponent_piece?).and_return(true, false, true, true)
        allow(moved_pawn_red).to receive(:out_of_bounds?).and_return(false)
        allow(moved_pawn_red).to receive(:king_or_same_color?).and_return(false)
      end

      it 'possible_moves has a limited set of moves' do
        moved_pawn_white.update_position([4, 6])
        moved_pawn_white.update_possible_moves(board_boxed_in_opposite)
        expect(moved_pawn_white.possible_moves).to eq([
          [3, 5],
          [3, 7]
        ])

        moved_pawn_red.update_position([3, 1])
        moved_pawn_red.update_possible_moves(board_boxed_in_opposite)
        expect(moved_pawn_red.possible_moves).to eq([
          [4, 0],
          [4, 2]
        ])
      end
    end

    context 'when the Pawn was moved and is surrounded by chess pieces that are the same color' do
      before do
        allow(moved_pawn_white).to receive(:opponent_piece?).and_return(false, false, false, false, false, false)
        allow(moved_pawn_white).to receive(:out_of_bounds?).and_return(false, false, false)
        allow(moved_pawn_white).to receive(:king_or_same_color?).and_return(true, true, true)
        allow(moved_pawn_red).to receive(:opponent_piece?).and_return(false, false, false, false, false, false)
        allow(moved_pawn_red).to receive(:out_of_bounds?).and_return(false, false, false)
        allow(moved_pawn_red).to receive(:king_or_same_color?).and_return(true, true, true)
      end

      it 'generates an empty set of moves for possible_moves' do
        moved_pawn_white.update_position([3, 1])
        moved_pawn_white.update_possible_moves(board_boxed_in_same)
        expect(moved_pawn_white.possible_moves).to eq([])

        moved_pawn_red.update_position([4, 6])
        moved_pawn_red.update_possible_moves(board_boxed_in_same)
        expect(moved_pawn_red.possible_moves).to eq([])
      end
    end

    context 'when the Pawn was moved and there are no pieces around' do
      before do
        allow(moved_pawn_white).to receive(:opponent_piece?).and_return(false, false, false, false, false, false)
        allow(moved_pawn_white).to receive(:out_of_bounds?).and_return(false, false, false)
        allow(moved_pawn_white).to receive(:king_or_same_color?).and_return(false, false, false)
        allow(moved_pawn_red).to receive(:opponent_piece?).and_return(false, false, false, false, false, false)
        allow(moved_pawn_red).to receive(:out_of_bounds?).and_return(false, false, false)
        allow(moved_pawn_red).to receive(:king_or_same_color?).and_return(false, false, false)
      end

      it 'possible_moves only has one move' do
        moved_pawn_white.update_position([4, 6])
        moved_pawn_white.update_possible_moves(board_empty)
        expect(moved_pawn_white.possible_moves).to eq([
          [3, 6]
        ])

        moved_pawn_red.update_position([3, 1])
        moved_pawn_red.update_possible_moves(board_empty)
        expect(moved_pawn_red.possible_moves).to eq([
          [4, 1]
        ])
      end
    end

    context 'when the Pawn was moved and there are chess pieces of a different color on the diagonals only' do
      before do
        allow(moved_pawn_white).to receive(:opponent_piece?).and_return(true, false, false, true)
        allow(moved_pawn_white).to receive(:out_of_bounds?).and_return(false,)
        allow(moved_pawn_white).to receive(:king_or_same_color?).and_return(false)
        allow(moved_pawn_red).to receive(:opponent_piece?).and_return(true, false, false, true)
        allow(moved_pawn_red).to receive(:out_of_bounds?).and_return(false)
        allow(moved_pawn_red).to receive(:king_or_same_color?).and_return(false)
      end

      it 'possible_moves has all moves' do
        moved_pawn_white.update_position([4, 6])
        moved_pawn_white.update_possible_moves(board_diagonals)
        expect(moved_pawn_white.possible_moves).to eq([
          [3, 5],
          [3, 6],
          [3, 7]
        ])

        moved_pawn_red.update_position([3, 1])
        moved_pawn_red.update_possible_moves(board_diagonals)
        expect(moved_pawn_red.possible_moves).to eq([
          [4, 0],
          [4, 1],
          [4, 2]
        ])
      end
    end

    context 'when the Pawn was moved and there are chess pieces of the same color on the diagonals only' do
      before do
        allow(moved_pawn_white).to receive(:opponent_piece?).and_return(false, false, false, false)
        allow(moved_pawn_white).to receive(:out_of_bounds?).and_return(false, false, false)
        allow(moved_pawn_white).to receive(:king_or_same_color?).and_return(true, false, true)
        allow(moved_pawn_red).to receive(:opponent_piece?).and_return(false, false, false, false)
        allow(moved_pawn_red).to receive(:out_of_bounds?).and_return(false, false, false)
        allow(moved_pawn_red).to receive(:king_or_same_color?).and_return(true, false, true)
      end

      it 'possible_moves only has one move' do
        moved_pawn_white.update_position([5, 1])
        moved_pawn_white.update_possible_moves(board_diagonals)
        expect(moved_pawn_white.possible_moves).to eq([[4, 1]])

        moved_pawn_red.update_position([2, 6])
        moved_pawn_red.update_possible_moves(board_diagonals)
        expect(moved_pawn_red.possible_moves).to eq([[3, 6]])
      end
    end

    context 'when the Pawn has not moved and there are no obstructions' do
      before do
        allow(unmoved_pawn_white).to receive(:opponent_piece?).and_return(false, false, false, false, false, false, false)
        allow(unmoved_pawn_white).to receive(:out_of_bounds?).and_return(false, false, false)
        allow(unmoved_pawn_white).to receive(:king_or_same_color?).and_return(false, false, false, false)
        allow(unmoved_pawn_red).to receive(:opponent_piece?).and_return(false, false, false, false, false, false, false)
        allow(unmoved_pawn_red).to receive(:out_of_bounds?).and_return(false, false, false)
        allow(unmoved_pawn_red).to receive(:king_or_same_color?).and_return(false, false, false, false)
      end

      it 'possible_moves has two forward moves' do
        unmoved_pawn_white.update_possible_moves(board_empty)
        expect(unmoved_pawn_white.possible_moves).to eq([
          [5, 1],
          [4, 1]
        ])

        unmoved_pawn_red.update_possible_moves(board_empty)
        expect(unmoved_pawn_red.possible_moves).to eq([
          [2, 5],
          [3, 5]
        ])
      end
    end

    context 'when the Pawn has not moved and there is a chess piece in front of it' do
      before do
        allow(unmoved_pawn_white).to receive(:opponent_piece?).and_return(false, false, true, true, false)
        allow(unmoved_pawn_white).to receive(:out_of_bounds?).and_return(false, false, false)
        allow(unmoved_pawn_white).to receive(:king_or_same_color?).and_return(false, false, false)
        allow(unmoved_pawn_red).to receive(:opponent_piece?).and_return(false, false, true, true, false)
        allow(unmoved_pawn_red).to receive(:out_of_bounds?).and_return(false, false, false)
        allow(unmoved_pawn_red).to receive(:king_or_same_color?).and_return(false, false, false)
      end
      
      it 'possible_moves is an empty array' do
        unmoved_pawn_white.update_possible_moves(board_block_forward_1)
        expect(unmoved_pawn_white.possible_moves).to eq([])
        
        unmoved_pawn_red.update_possible_moves(board_block_forward_1)
        expect(unmoved_pawn_red.possible_moves).to eq([])
      end
    end

    context 'when the Pawn has not moved and there is a chess piece two squares in front of it' do
      before do
        allow(unmoved_pawn_white).to receive(:opponent_piece?).and_return(false, false, false, false, false, false, false)
        allow(unmoved_pawn_white).to receive(:out_of_bounds?).and_return(false, false, false)
        allow(unmoved_pawn_white).to receive(:king_or_same_color?).and_return(false, false, true, false)
        allow(unmoved_pawn_red).to receive(:opponent_piece?).and_return(false, false, false, false, false, false, false)
        allow(unmoved_pawn_red).to receive(:out_of_bounds?).and_return(false, false, false)
        allow(unmoved_pawn_red).to receive(:king_or_same_color?).and_return(false, false, true, false)
      end

      it 'possible_moves only has one move forward' do
        unmoved_pawn_white.update_possible_moves(board_block_forward_2)
        expect(unmoved_pawn_white.possible_moves).to eq([[5, 1]])

        unmoved_pawn_red.update_possible_moves(board_block_forward_2)
        expect(unmoved_pawn_red.possible_moves).to eq([[2, 5]])
      end
    end
  

    context 'when the Pawn has moved and is positioned near the edge of the board' do
      before do
        allow(moved_pawn_white_edge).to receive(:opponent_piece?).and_return(false, false, false, false, false)
        allow(moved_pawn_white_edge).to receive(:out_of_bounds?).and_return(true, false, false)
        allow(moved_pawn_white_edge).to receive(:king_or_same_color?).and_return(false, false)
        allow(moved_pawn_red_edge).to receive(:opponent_piece?).and_return(false, false, false, false, false)
        allow(moved_pawn_red_edge).to receive(:out_of_bounds?).and_return(false, false, true)
        allow(moved_pawn_red_edge).to receive(:king_or_same_color?).and_return(false, false)
      end

      it 'possible_moves only has one forward move' do
        moved_pawn_white_edge.update_position([4, 7])
        moved_pawn_white_edge.update_possible_moves(board_edges)
        expect(moved_pawn_white_edge.possible_moves).to eq([[3, 7]])

        moved_pawn_red_edge.update_position([2, 0])
        moved_pawn_red_edge.update_possible_moves(board_edges)
        expect(moved_pawn_red_edge.possible_moves).to eq([[3, 0]])
      end
    end
  end

  describe '#remove_en_passant' do
    subject(:pawn_white) { described_class.new('white', [6, 2]) }
    subject(:pawn_red) {  described_class.new('red', [1, 5]) }
    subject(:opposing_pawn_white_1) { described_class.new('white', [6, 6]) }
    subject(:opposing_pawn_red_1) { described_class.new('red', [1, 1]) }
    subject(:opposing_pawn_white_2) { described_class.new('white', [6, 4]) }
    subject(:opposing_pawn_red_2) { described_class.new('red', [1, 3]) }
    
    let(:board) { [
      pawn_white,
      pawn_red,
      opposing_pawn_white_1,
      opposing_pawn_white_2,
      opposing_pawn_red_1,
      opposing_pawn_red_2
    ] }

    before do
      pawn_white.update_position([4, 2])
      pawn_white.update_possible_moves(board)
      pawn_white.update_position([3, 2])
      pawn_white.update_possible_moves(board)

      pawn_red.update_position([3, 5])
      pawn_red.update_possible_moves(board)
      pawn_red.update_position([4, 5])
      pawn_red.update_possible_moves(board)

      opposing_pawn_white_1.update_position([4, 6])
      opposing_pawn_red_1.update_position([3, 1])
      opposing_pawn_white_2.update_position([4, 4])
      opposing_pawn_red_2.update_position([3, 3])
    end

    context 'when there are no moves in en_passant_moves' do
      it 'no moves are removed in possible_moves' do
        expect(pawn_white.en_passant_moves).to eq([])
        expect(pawn_red.en_passant_moves).to eq([])
        expect(pawn_white.possible_moves).to eq([[2, 2]])
        expect(pawn_red.possible_moves).to eq([[5, 5]])

        pawn_white.remove_en_passant
        expect(pawn_white.possible_moves).to eq([[2, 2]])
        pawn_red.remove_en_passant
        expect(pawn_red.possible_moves).to eq([[5, 5]])
      end
    end

    context 'when there are moves in en_passant_moves and the first entry is in the possible_moves array' do
      it 'removes the first entry from possible_moves' do
        pawn_white.possible_moves = [
          [2, 2],
          [2, 1]
        ]
        pawn_white.en_passant_moves= [[2, 1]]
        expect(pawn_white.possible_moves).to eq([
          [2, 2],
          [2, 1]
        ])
        pawn_white.remove_en_passant
        expect(pawn_white.possible_moves).to eq([[2, 2]])

        pawn_white.possible_moves = [
          [2, 2],
          [2, 3]
        ]
        pawn_white.en_passant_moves = [[2, 3]]
        expect(pawn_white.possible_moves).to eq([
          [2, 2],
          [2, 3]
        ])
        pawn_white.remove_en_passant
        expect(pawn_white.possible_moves).to eq([[2, 2]])

        pawn_red.possible_moves = [
          [5, 5],
          [5, 4]
        ]
        pawn_red.en_passant_moves= [[5, 4]]
        expect(pawn_red.possible_moves).to eq([
          [5, 5],
          [5, 4]
        ])
        pawn_red.remove_en_passant
        expect(pawn_red.possible_moves).to eq([[5, 5]])

        pawn_red.possible_moves = [
          [5, 5],
          [5, 6]
        ]
        pawn_red.en_passant_moves = [[5, 6]]
        expect(pawn_red.possible_moves).to eq([
          [5, 5],
          [5, 6]
        ])
        pawn_red.remove_en_passant
        expect(pawn_red.possible_moves).to eq([[5, 5]])
      end
    end

    context 'when there are moves in en_passant_moves but not in the possible_moves array' do
      it 'no moves are removed in possible_moves' do
        pawn_white.possible_moves = [[2, 2]]
        pawn_white.en_passant_moves = [[2, 1]]
        expect(pawn_white.possible_moves).to eq([[2, 2]])
        pawn_white.remove_en_passant
        expect(pawn_white.possible_moves).to eq([[2, 2]])

        pawn_red.possible_moves = [[5, 5]]
        pawn_red.en_passant_moves = [[5, 6]]
        expect(pawn_red.possible_moves).to eq([[5, 5]])
        pawn_white.remove_en_passant
        expect(pawn_red.possible_moves).to eq([[5, 5]])
      end
    end
  end
end