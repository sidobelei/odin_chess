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
        expect(white_pawn1.position).to eq([nil, nil])
        expect(white_pawn1.promoted).to eq(true)
        expect(white_pawn2.position).to eq([nil, nil])
        expect(white_pawn2.promoted).to eq(true)
        expect(white_pawn3.position).to eq([nil, nil])
        expect(white_pawn3.promoted).to eq(true)
        expect(white_pawn4.position).to eq([nil, nil])
        expect(white_pawn4.promoted).to eq(true)
        expect(white_pawn5.position).to eq([nil, nil])
        expect(white_pawn5.promoted).to eq(true)
        expect(white_pawn6.position).to eq([nil, nil])
        expect(white_pawn6.promoted).to eq(true)
        expect(white_pawn7.position).to eq([nil, nil])
        expect(white_pawn7.promoted).to eq(true)
        expect(white_pawn8.position).to eq([nil, nil])
        expect(white_pawn8.promoted).to eq(true)
        expect(red_pawn1.position).to eq([nil, nil])
        expect(red_pawn1.promoted).to eq(true)
        expect(red_pawn2.position).to eq([nil, nil])
        expect(red_pawn2.promoted).to eq(true)
        expect(red_pawn3.position).to eq([nil, nil])
        expect(red_pawn3.promoted).to eq(true)
        expect(red_pawn4.position).to eq([nil, nil])
        expect(red_pawn4.promoted).to eq(true)
        expect(red_pawn5.position).to eq([nil, nil])
        expect(red_pawn5.promoted).to eq(true)
        expect(red_pawn6.position).to eq([nil, nil])
        expect(red_pawn6.promoted).to eq(true)
        expect(red_pawn7.position).to eq([nil, nil])
        expect(red_pawn7.promoted).to eq(true)
        expect(red_pawn8.position).to eq([nil, nil])
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
    subject(:white_en_passant) { described_class.new('white', [4, 6]) }
    subject(:red_en_passant) { described_class.new('red', [3, 2]) }
    let(:knight1) { double('Knight', color: 'red', name: 'N', type: 'knight', position: [3, 5]) }
    let(:pawn1) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [3, 6], moved: 0) }
    let(:pawn2) { double('Pawn', color: 'red', name: 'P', type: 'pawn', position: [3, 7], moved: 0) }
    let(:bishop1) { double('Bishop', color: 'red', name: 'B', type: 'bishop', position: [4, 5]) }
    let(:bishop2) { double('Bishop', color: 'red', name: 'B', type: 'bishop', position: [5, 5]) }
    let(:rook1) { double('Rook', color: 'red', name: 'R', type: 'rook', position: [4, 7]) }
    let(:rook2) { double('Rook', color: 'red', name: 'R', type: 'rook', position: [5, 6]) }
    let(:queen1) { double('Queen', color: 'red', name: 'Q', type: 'queen', position: [5, 7]) }
    let(:knight2) { double('Knight', color: 'white', name: 'N', type: 'knight', position: [4, 0]) }
    let(:pawn3) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [4, 1], moved: 0) }
    let(:pawn4) { double('Pawn', color: 'white', name: 'P', type: 'pawn', position: [4, 2], moved: 0) }
    let(:bishop3) { double('Bishop', color: 'white', name: 'B', type: 'bishop', position: [3, 0]) }
    let(:bishop4) { double('Bishop', color: 'white', name: 'B', type: 'bishop', position: [2, 0]) }
    let(:rook3) { double('Rook', color: 'white', name: 'R', type: 'rook', position: [3, 2]) }
    let(:rook4) { double('Rook', color: 'white', name: 'R', type: 'rook', position: [2, 1]) }
    let(:queen2) { double('Queen', color: 'white', name: 'Q', type: 'queen', position: [2, 2]) }
    let(:king1) { double('King', color: 'white', name: 'K', type: 'king', position: [4, 1]) }
    let(:king2) { double('King', color: 'red', name: 'K', type: 'king', position: [3, 5]) }
    let(:knight3) { double('Knight', color: 'white', name: 'N', type: 'knight', position: [2, 5]) }
    let(:knight4) { double('Knight', color: 'red', name: 'N', type: 'knight', position: [5, 1]) }
    let(:knight5) { double('Knight', color: 'white', name: 'N', type: 'knight', position: [5, 3]) }
    let(:knight6) { double('Knight', color: 'red', name: 'N', type: 'knight', position: [2, 7]) }
    let(:king_in_check) { double('King', color: 'red', name: 'K', type: 'king', position: [4, 7]) }
    let(:my_king) { double('King', color: 'white', name: 'K', type: 'king', position: [4, 7]) }
    let(:white_king) { double('King', color: 'white', name: 'K', type: 'king', position: [7, 0]) }
    let(:red_king) { double('King', color: 'red', name: 'K', type: 'king', position: [0, 7]) }
    let(:checking_rook) { double('Rook', color: 'white', name: 'R', type: 'rook', position: [7, 7]) }
    let(:checking_bishop) { double('Bishop', color: 'white', name: 'B', type: 'bishop', position: [7, 4]) }

    let(:board_boxed_in_opposite) { [
      moved_pawn_white,
      white_king,
      knight1,
      pawn1,
      pawn2,
      bishop1,
      bishop2,
      rook1,
      rook2,
      queen1,
      moved_pawn_red,
      red_king,
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
      white_king,
      knight1,
      pawn1,
      pawn2,
      bishop1,
      bishop2,
      rook1,
      rook2,
      queen1,
      moved_pawn_red,
      red_king,
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
      white_king,
      moved_pawn_red,
      red_king,
      unmoved_pawn_white,
      unmoved_pawn_red
    ] }

    let(:board_diagonals) { [
      moved_pawn_white,
      white_king,
      knight1,
      pawn2,
      moved_pawn_red,
      red_king,
      knight2,
      pawn4
    ] }

    let(:board_block_forward_1) { [
      unmoved_pawn_white,
      white_king,
      knight3,
      unmoved_pawn_red,
      red_king,
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
      white_king,
      moved_pawn_red_edge,
      red_king
    ] }

    let(:board_en_passant) { [
      white_en_passant,
      white_king,
      red_en_passant,
      red_king,
      unmoved_pawn_white,
      unmoved_pawn_red,
      knight5,
      knight6
    ] }

    let(:board_in_check) { [
      moved_pawn_white,
      white_king,
      king_in_check
    ] }

    let(:board_my_king) { [
      moved_pawn_white,
      my_king
    ] }

    let(:board_capture) { [
      moved_pawn_red,
      king_in_check,
      checking_rook
    ] }

    let(:board_block_and_no_move) { [
      moved_pawn_red,
      king_in_check,
      checking_bishop
    ] }
    
    context 'when the Pawn was moved and is surrounded by chess pieces that are of a different color' do
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
      it 'possible_moves is an empty array' do
        unmoved_pawn_white.update_possible_moves(board_block_forward_1)
        expect(unmoved_pawn_white.possible_moves).to eq([])
        
        unmoved_pawn_red.update_possible_moves(board_block_forward_1)
        expect(unmoved_pawn_red.possible_moves).to eq([])
      end
    end

    context 'when the Pawn has not moved and there is a chess piece two squares in front of it' do
      it 'possible_moves only has one move forward' do
        unmoved_pawn_white.update_possible_moves(board_block_forward_2)
        expect(unmoved_pawn_white.possible_moves).to eq([[5, 1]])

        unmoved_pawn_red.update_possible_moves(board_block_forward_2)
        expect(unmoved_pawn_red.possible_moves).to eq([[2, 5]])
      end
    end
    
    context 'when the opponent King is in the path of the Pawn' do
      it 'generates a set of moves that includes the opponent King' do
        moved_pawn_white.update_position([5, 6])
        moved_pawn_white.update_possible_moves(board_in_check)
        expect(moved_pawn_white.possible_moves).to eq([
          [4, 6],
          [4, 7]
        ])
      end
    end

    context 'when your King is in the path of your Pawn' do
      it 'generates a set of moves that excludes your King' do
        moved_pawn_white.update_position([5, 6])
        moved_pawn_white.update_possible_moves(board_my_king)
        expect(moved_pawn_white.possible_moves).to eq([
          [4, 6]
        ])
      end
    end

    context 'when the Pawn has moved and is positioned near the edge of the board' do
      it 'possible_moves only has one forward move' do
        moved_pawn_white_edge.update_position([4, 7])
        moved_pawn_white_edge.update_possible_moves(board_edges)
        expect(moved_pawn_white_edge.possible_moves).to eq([[3, 7]])

        moved_pawn_red_edge.update_position([2, 0])
        moved_pawn_red_edge.update_possible_moves(board_edges)
        expect(moved_pawn_red_edge.possible_moves).to eq([[3, 0]])
      end
    end

    context 'when there is a opportunity of an en_passant move while there are other chess pieces around' do
      it 'generates the correct set of moves and extra en passant move' do
        white_en_passant.update_position([3, 6])#
        unmoved_pawn_red.update_position([3, 5])
        white_en_passant.update_possible_moves(board_en_passant)
        expect(white_en_passant.possible_moves).to eq([
          [2, 6],
          [2, 7],
          [2, 5]
        ])

        red_en_passant.update_position([4, 2])
        unmoved_pawn_white.update_position([4, 1])
        red_en_passant.update_possible_moves(board_en_passant)
        expect(red_en_passant.possible_moves).to eq([
          [5, 2],
          [5, 3],
          [5, 1]
        ])
      end
    end

    context "when the Pawn's only move is to capture the opposing piece that is causing a check" do
      it 'generates only the move to capture the opposing piece causing the check' do
        moved_pawn_red.update_position([6, 6])
        moved_pawn_red.update_possible_moves(board_capture)
        expect(moved_pawn_red.possible_moves).to eq([[7, 7]])
      end
    end

    context "when the Pawn's only move is to block the opposing piece's check" do
      it "generates only the move that will block the opposing pieces's check" do
        moved_pawn_red.update_position([4, 6])
        moved_pawn_red.update_possible_moves(board_block_and_no_move)
        expect(moved_pawn_red.possible_moves).to eq([[5, 6]])
      end
    end

    context 'when the Pawn cannot move because it would place its King in check' do
      it 'generates no moves' do
        moved_pawn_red.update_position([5, 6])
        moved_pawn_red.update_possible_moves(board_block_and_no_move)
        expect(moved_pawn_red.possible_moves).to eq([])
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
    let(:white_king) { double('King', color: 'white', name: 'K', type: 'king', position: [7, 0]) }
    let(:red_king) { double('King', color: 'red', name: 'K', type: 'king', position: [0, 7]) } 
    
    let(:board) { [
      pawn_white,
      white_king,
      pawn_red,
      red_king,
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

  describe '#add_en_passant' do
    subject(:pawn_white) { described_class.new('white', [6, 1]) }
    subject(:pawn_red) { described_class.new('red', [1, 6]) }
    subject(:opposing_pawn_white_left) { described_class.new('white', [6, 5]) }
    subject(:opposing_pawn_white_right) { described_class.new('white', [6, 7]) }
    subject(:opposing_pawn_red_left) { described_class.new('red', [1, 0]) }
    subject(:opposing_pawn_red_right) { described_class.new('red', [1, 2]) }
    let(:bishop_white_left) { double('Bishop', color: 'white', name: 'B', type: 'bishop', position: [5, 5]) }
    let(:rook_white_right) { double('Rook', color: 'white', name: 'R', type: 'rook', position: [5, 7], moved: 1) }
    let(:rook_red_left) { double('Rook', color: 'red', name: 'R', type: 'rook', position: [3, 0], moved: 1) }
    let(:bishop_red_right) { double('Bishop', color: 'red', name: 'B', type: 'bishop', position: [3, 2]) }
    let(:knight_left_1) { double('Knight', color: 'white', name: 'N', type: 'knight', position: [2, 0]) }
    let(:knight_right_2) { double('Knight', color: 'red', name: 'N', type: 'knight', position: [2, 2]) }
    let(:knight_left_3) { double('Knight', color: 'red', name: 'N', type: 'knight', position: [5, 7]) }
    let(:knight_right_4) { double('Knight', color: 'white', name: 'N', type: 'knight', position: [5, 5]) }
    let(:white_king) { double('King', color: 'white', name: 'K', type: 'king', position: [7, 0]) }
    let(:red_king) { double('King', color: 'red', name: 'K', type: 'king', position: [0, 7]) }

    before do
      pawn_white.update_position([4, 1])
      pawn_white.update_position([3, 1])
      
      pawn_red.update_position([3, 6])
      pawn_red.update_position([4, 6])

      opposing_pawn_white_left.update_position([4, 5])
      opposing_pawn_white_right.update_position([4, 7])
      opposing_pawn_red_left.update_position([3, 0])
      opposing_pawn_red_right.update_position([3, 2])
    end

    let(:board_no_en_passant) { [
      pawn_white,
      white_king,
      pawn_red,
      red_king,
      bishop_white_left,
      rook_white_right,
      rook_red_left,
      bishop_red_right
    ] }

    let(:board_left_en_passant) { [
      pawn_white,
      white_king,
      pawn_red,
      red_king,
      opposing_pawn_white_left,
      opposing_pawn_red_left
    ] }
    
    let(:board_right_en_passant) { [
      pawn_white,
      white_king,
      pawn_red,
      red_king,
      opposing_pawn_white_right,
      opposing_pawn_red_right
    ] }

    let(:board_blocked_en_passant) { [
      pawn_white,
      white_king,
      pawn_red,
      red_king,
      opposing_pawn_white_left,
      opposing_pawn_red_left,
      knight_left_1,
      knight_left_3,
      knight_right_2,
      knight_right_4
    ] }

    context 'when there is no opportunity for an en passant move' do
      it 'no extra move is added to possible_moves' do
        pawn_white.possible_moves = [[2, 1]]
        old_white_moves = pawn_white.possible_moves   
        pawn_white.add_en_passant(board_no_en_passant)
        expect(pawn_white.possible_moves).to eq(old_white_moves)

        pawn_red.possible_moves = [[5, 6]]
        old_red_moves = pawn_red.possible_moves
        pawn_red.add_en_passant(board_no_en_passant)
        expect(pawn_red.possible_moves).to eq(old_red_moves)
      end    
    end

    context 'when there is an en passant opportunity to the left of the pawn' do
      it 'adds an extra move to possible_moves' do 
        pawn_white.possible_moves = [[2, 1]]
        pawn_white.add_en_passant(board_left_en_passant)
        expect(pawn_white.possible_moves).to eq([
          [2, 1],
          [2, 0]
        ])

        pawn_red.possible_moves = [[5, 6]]
        pawn_red.add_en_passant(board_left_en_passant)
        expect(pawn_red.possible_moves).to eq([
          [5, 6],
          [5, 5]
        ])           
      end    
    end

    context 'when there is an en passant opportunity to the right of the pawn' do
      it 'adds an extra move to possible_moves' do 
        pawn_white.possible_moves = [[2, 1]]
        pawn_white.add_en_passant(board_right_en_passant)
        expect(pawn_white.possible_moves).to eq([
          [2, 1],
          [2, 2]
        ])

        pawn_red.possible_moves = [[5, 6]]
        pawn_red.add_en_passant(board_right_en_passant)
        expect(pawn_red.possible_moves).to eq([
          [5, 6],
          [5, 7]
        ])           
      end     
    end

    context 'when there is an en passant opportunity but there is a chess piece in the desired destination' do
      it 'does not add extra en passant move to possible_moves' do
        pawn_white.possible_moves = [
          [2, 1],
          [2, 2]
        ]
        pawn_white.add_en_passant(board_blocked_en_passant)
        expect(pawn_white.possible_moves).to eq([
          [2, 1],
          [2, 2]
        ])

        pawn_red.possible_moves = [
          [5, 6],
          [5, 7]
        ]
        pawn_red.add_en_passant(board_blocked_en_passant)
        expect(pawn_red.possible_moves).to eq([
          [5, 6],
          [5, 7]
        ])
      end
    end
  end
end