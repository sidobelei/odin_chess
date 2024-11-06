require_relative '../lib/king'

describe King do
  describe '#initialize' do
    subject(:king_white) { described_class.new('white', [7, 4]) }
    subject(:king_red) { described_class.new('red', [0, 4]) }
    context 'when a King object is initialized' do
      it 'assigns a color attribute' do
        expect(king_white.color).to eq('white')
        expect(king_red.color).to eq('red')
      end

      it 'assigns a name attribute' do
        expect(king_white.name).to eq("\e[1m\e[37mK\e[0m")
        expect(king_red.name).to eq("\e[1m\e[31mK\e[0m")
      end

      it 'assigns a type attribute' do
        expect(king_white.type).to eq('king')
        expect(king_red.type).to eq('king')
      end

      it 'assigns a position attribute' do
        expect(king_white.position).to eq([7, 4])
        expect(king_red.position).to eq([0, 4])
      end

      it 'assigns zero to the moved attribute' do
        expect(king_white.moved).to eq(0)
        expect(king_red.moved).to eq(0)
      end
    end
  end

  describe '#update_position' do
    subject(:unmoved_white_king) { described_class.new('white', [7, 4]) }
    subject(:unmoved_red_king) { described_class.new('red', [0, 4]) }
    subject(:moved_white_king) { described_class.new('white', [7, 4]) }
    subject(:moved_red_king) { described_class.new('red', [0, 4]) }
    
    context 'when the King has not moved and is changing position' do
      it 'position is updated and the moved attribute is one' do
        unmoved_white_king.update_position([6, 4])
        expect(unmoved_white_king.position).to eq([6, 4])
        expect(unmoved_white_king.moved).to eq(1)
        
        unmoved_red_king.update_position([1, 4])
        expect(unmoved_red_king.position).to eq([1, 4])
        expect(unmoved_red_king.moved).to eq(1)
      end
    end

    context 'when the King has moved previously and is changing position' do
      it 'position is updated and the moved attribute increases by one' do
        moved_white_king.update_position([6, 4])
        moved_white_king.update_position([5, 4])
        moved_white_king.update_position([4, 4])
        expect(moved_white_king.position).to eq([4, 4])
        expect(moved_white_king.moved).to eq(3)
        moved_white_king.update_position([3, 4])
        expect(moved_white_king.position).to eq([3, 4])
        expect(moved_white_king.moved).to eq(4)
        
        moved_red_king.update_position([1, 4])
        moved_red_king.update_position([2, 4])
        moved_red_king.update_position([3, 4])
        expect(moved_red_king.position).to eq([3, 4])
        expect(moved_red_king.moved).to eq(3)
        moved_red_king.update_position([4, 4])
        expect(moved_red_king.position).to eq([4, 4])
        expect(moved_red_king.moved).to eq(4)
      end
    end

    context 'when a castling move is made' do
      it 'updates its position and returns the new Rook position' do
        expect(unmoved_white_king.update_position('[0-0-0]')).to eq([unmoved_white_king.position[0], 3])
        expect(unmoved_white_king.position).to eq([unmoved_white_king.position[0], 2])

        expect(unmoved_white_king.update_position('[0-0]')).to eq([unmoved_white_king.position[0], 5])
        expect(unmoved_white_king.position).to eq([unmoved_white_king.position[0], 6])
      end
    end
  end

  describe '#in_check?' do
    subject(:in_check_king) {described_class.new('red', [2, 6])}
    let(:pawn_check) { double('Pawn', color: 'white', type: 'pawn', position: [3, 7], possible_moves: [[2, 7], [2, 6]]) }
    let(:rook_check) { double('Rook', color: 'white', type: 'rook', position: [2, 3], possible_moves: [
      [1, 3],
      [0, 3],
      [2, 4],
      [2, 5],
      [2, 6]
    ]) }
    let(:knight_check) { double('Knight', color: 'white', type: 'knight', position: [4, 5], possible_moves: [
      [2, 4],
      [2, 6],
      [5, 7],
      [6, 6],
      [6, 4],
      [5, 3],
      [3, 3]
    ]) }
    let(:bishop_check) { double('Bishop', color: 'white', type: 'bishop', position: [1, 7], possible_moves: [[2, 6]]) }
    let(:queen_check) { double('Queen', color: 'white', type: 'queen', position: [0, 6], possible_moves: [[
      [0, 7],
      [1, 6],
      [2, 6],
      [1, 5],
      [2, 4],
      [3, 3],
      [4, 2],
      [5, 1],
      [6, 0]
    ]]) }
    let(:noncheck_knight) { double('Knight', color: 'red', type: 'knight', position: [0, 3], possible_moves: [
      [1, 5],
      [2, 4],
      [2, 2],
      [1, 1]
      ]) }
    let(:noncheck_rook) { double('Rook', color: 'white', type: 'rook', position: [2, 5], possible_moves: [
      [1, 5],
      [0, 5],
      [3, 5],
      [4, 5],
      [6, 5],
      [7, 5],
      [2, 4],
      [2, 3],
      [2, 1],
      [2, 0]
      ]) }
    let(:noncheck_bishop) { double('Bishop', color: 'red', type: 'bishop', position: [7, 2], possible_moves: [
      [6, 1],
      [5, 0],
      [6, 3],
      [5, 4],
      [4, 5]
      ]) }
    let(:noncheck_queen) { double('Queen', color: 'white', type: 'queen', position: [7, 7], possible_moves: [
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
      [7 ,5],
      [7, 4],
      [7, 3],
      [7, 2]
    ]) }

    let(:board_no_check) {[
      in_check_king,
      noncheck_knight,
      noncheck_rook,
      noncheck_bishop,
      noncheck_queen
    ]}
    let(:board_one_check) {[
      in_check_king,
      knight_check,
      noncheck_knight,
      noncheck_rook,
      noncheck_bishop,
      noncheck_queen
    ]}
    let(:board_multi_check) {[
      in_check_king,
      pawn_check,
      rook_check,
      bishop_check,
      knight_check,
      queen_check
    ]}

    context 'when the King is not in check' do
      it 'returns false' do
        expect(in_check_king.in_check?(board_no_check, [2, 6])).to eq(false)
      end
    end

    context 'when the King is in check by one chess piece' do
      it 'returns true' do
        expect(in_check_king.in_check?(board_one_check, [2, 6])).to eq(true)
      end
    end

    context 'when the King is in check by multiple pieces' do
      it 'returns true' do
        expect(in_check_king.in_check?(board_multi_check, [2, 6]))
      end
    end
  end

  describe '#remove_castling' do
    subject(:king_white) {described_class.new('white', [7, 4]) }
    subject(:king_red) { described_class.new('red', [0, 4]) }
    
    context 'when there are two possible castling moves' do
      it 'removes both castling moves' do
        king_white.possible_moves = [
          [6, 3],
          [6, 4],
          [6, 5],
          [0, 5],
          [0, 3],
          '[0-0-0]',
          '[0-0]'
        ]
        king_white.remove_castling
        expect(king_white.possible_moves).to eq([
          [6, 3],
          [6, 4],
          [6, 5],
          [0, 5],
          [0, 3]
        ])

        
        king_red.possible_moves = [
          [0, 5],
          [1, 5],
          [1, 4],
          [1, 3],
          [0, 3],
          '[0-0-0]',
          '[0-0]'
        ]
        king_red.remove_castling
        expect(king_red.possible_moves).to eq([
          [0, 5],
          [1, 5],
          [1, 4],
          [1, 3],
          [0, 3]
        ])
      end
    end

    context 'when there is only one possible castling move' do
      it 'removes the one castling move' do
        king_white.possible_moves = [
          [6, 3],
          [6, 4],
          [6, 5],
          [0, 5],
          [0, 3],
          '[0-0-0]'
        ]
        king_white.remove_castling
        expect(king_white.possible_moves).to eq([
          [6, 3],
          [6, 4],
          [6, 5],
          [0, 5],
          [0, 3]
        ])

        king_red.possible_moves = [
          [0, 5],
          [1, 5],
          [1, 4],
          [1, 3],
          [0, 3],
          '[0-0]'
        ]
        king_red.remove_castling
        expect(king_red.possible_moves).to eq([
          [0, 5],
          [1, 5],
          [1, 4],
          [1, 3],
          [0, 3]
        ])
      end
    end

    context 'when there are no possible castling moves' do
      it 'removes nothing' do
        king_white.possible_moves = [
          [6, 3],
          [6, 4],
          [6, 5],
          [0, 5],
          [0, 3]
        ]
        king_white.remove_castling
        expect(king_white.possible_moves).to eq([
          [6, 3],
          [6, 4],
          [6, 5],
          [0, 5],
          [0, 3]
        ])

        king_red.possible_moves = [
          [0, 5],
          [1, 5],
          [1, 4],
          [1, 3],
          [0, 3]
        ]
        king_red.remove_castling
        expect(king_red.possible_moves).to eq([
          [0, 5],
          [1, 5],
          [1, 4],
          [1, 3],
          [0, 3]
        ])
      end
    end
  end

  describe '#add_castling' do
    subject(:king_white) { described_class.new('white', [7, 4]) }
    subject(:king_red) { described_class.new('red', [0, 4]) }
    let(:unmoved_rook_white_left) { double('Rook', color: 'white', type: 'rook', position: [7, 0], moved: 0, possible_moves: []) }
    let(:unmoved_rook_white_right) { double('Rook', color: 'white', type: 'rook', position: [7, 7], moved: 0, possible_moves: []) }
    let(:unmoved_rook_red_left) { double('Rook', color: 'red', type: 'rook', position: [0, 0], moved: 0, possible_moves: []) }
    let(:unmoved_rook_red_right) { double('Rook', color: 'red', type: 'rook', position: [0, 7], moved: 0, possible_moves: []) }
    let(:moved_rook_white_left) { double('Rook', color: 'white', type: 'rook', position: [7, 2], moved: 1, possible_moves: []) }
    let(:moved_rook_white_right) { double('Rook', color: 'white', type: 'rook', position: [7, 6], moved: 1, possible_moves: []) }
    let(:moved_rook_red_left) { double('Rook', color: 'red', type: 'rook', position: [0, 1], moved: 1, possible_moves: []) }
    let(:moved_rook_red_right) { double('Rook', color: 'red', type: 'rook', position: [0, 5], moved: 1, possible_moves: []) }
    
    let(:knight_white) { double('Knight', color: 'white', type: 'knight', position: [7, 1], possible_moves: []) } 
    let(:bishop_white) { double('Bishop', color: 'white', type: 'bishop', position: [7, 2], possible_moves: []) }
    let(:queen_white) { double('Queen', color: 'white', type: 'queen', position: [7, 3], possible_moves: []) }
    let(:bishop_red) { double('Bishop', color: 'red', type: 'bishop', position: [7, 5], possible_moves: []) }
    let(:knight_red) { double('Knight', color: 'red', type: 'knight', position: [7, 6], possible_moves: []) }

    let(:knight_red_2) { double('Knight', color: 'red', type: 'knight', position: [0, 1], possible_moves: []) }
    let(:bishop_white_2) { double('Bishop', color: 'white', type: 'bishop', position: [0, 2], possible_moves: []) }
    let(:queen_red) { double('Queen', color: 'red', type: 'queen', position: [0, 3], possible_moves: []) }
    let(:bishop_red_2) { double('Bishop', color: 'red', type: 'bishop', position: [0, 5], possible_moves: []) }
    let(:knight_white_2) { double('Knight', color: 'white', type: 'knight', position: [0, 6], possible_moves: []) }

    let(:rook_check) { double('Rook', color: 'red', type: 'rook', position: [5, 2], possible_moves: [[6, 2], [7, 2]]) }
    let(:knight_check) { double('Knight', color: 'red', type: 'knight', position: [5, 6], possible_moves: [[7, 5], [6, 4]]) }

    let(:board_unmoved_all_unblocked) {[
      king_white,
      king_red,
      unmoved_rook_white_left,
      unmoved_rook_white_right,
      unmoved_rook_red_left,
      unmoved_rook_red_right
    ]}
    let(:board_unmoved_king_unblocked) {[
      king_white,
      king_red,
      moved_rook_white_left,
      moved_rook_white_right,
      moved_rook_red_left,
      moved_rook_red_right
    ]}
    let(:board_unmoved_king_one_rook_unblocked) {[
      king_white,
      king_red,
      unmoved_rook_white_left,
      moved_rook_white_right,
      moved_rook_red_left,
      unmoved_rook_red_right
    ]}
    let(:board_unmoved_rooks_unblocked) {[
      king_white,
      king_red,
      unmoved_rook_white_left,
      unmoved_rook_white_right,
      unmoved_rook_red_left,
      unmoved_rook_red_right
    ]}
    let(:board_moved_all_unblocked) { [
      king_white,
      king_red,
      moved_rook_white_left,
      moved_rook_white_right,
      moved_rook_red_left,
      moved_rook_red_right
    ] }

    let(:board_unmoved_all_blocked_partial) { [
      king_white,
      king_red,
      unmoved_rook_white_left,
      unmoved_rook_white_right,
      unmoved_rook_red_left,
      unmoved_rook_red_right,
      knight_white,
      bishop_red,
      queen_red,
      knight_white_2
    ] }
    let(:board_unmoved_king_blocked_partial) { [
      king_white,
      king_red,
      moved_rook_white_left,
      moved_rook_white_right,
      moved_rook_red_left,
      moved_rook_red_right,
      knight_white,
      bishop_red,
      queen_red,
      knight_white_2
    ] }
    let(:board_unmoved_king_one_rook_blocked_partial) { [
      king_white,
      king_red,
      moved_rook_white_left,
      unmoved_rook_white_right,
      unmoved_rook_red_left,
      moved_rook_red_right,
      knight_white,
      bishop_red,
      queen_red,
      knight_white_2
    ] }
    let(:board_unmoved_rooks_blocked_partial) { [
      king_white,
      king_red,
      unmoved_rook_white_left,
      unmoved_rook_white_right,
      unmoved_rook_red_left,
      unmoved_rook_red_right,
      knight_white,
      bishop_red,
      queen_red,
      knight_white_2
    ] }
    let(:board_moved_all_blocked_partial) { [
      king_white,
      king_red,
      moved_rook_white_left,
      moved_rook_white_right,
      moved_rook_red_left,
      moved_rook_red_right,
      knight_white,
      bishop_red,
      queen_red,
      knight_white_2
    ] }

    let(:board_unmoved_all_blocked_all) { [
      king_white,
      king_red,
      unmoved_rook_white_left,
      unmoved_rook_white_right,
      unmoved_rook_red_left,
      unmoved_rook_red_right,
      knight_white,
      bishop_white,
      queen_white,
      bishop_red,
      knight_red,
      knight_red_2,
      bishop_white_2,
      queen_red,
      bishop_red_2,
      knight_white_2
    ] }
    let(:board_unmoved_king_blocked_all) { [
      king_white,
      king_red,
      moved_rook_white_left,
      moved_rook_white_right,
      moved_rook_red_left,
      moved_rook_red_right,
      knight_white,
      queen_white,
      bishop_red,
      bishop_white_2,
      queen_red,
      knight_white_2
    ] }
    let(:board_unmoved_king_one_rook_blocked_all) { [
      king_white,
      king_red,
      unmoved_rook_white_left,
      moved_rook_white_right,
      unmoved_rook_red_left,
      moved_rook_red_right,
      knight_white,
      bishop_white,
      queen_white,
      bishop_red,
      knight_red_2,
      bishop_white_2,
      queen_red,
      knight_white_2
    ] }
    let(:board_unmoved_rooks_blocked_all) { [
      king_white,
      king_red,
      unmoved_rook_white_left,
      unmoved_rook_white_right,
      unmoved_rook_red_left,
      unmoved_rook_red_right,
      knight_white,
      bishop_white,
      queen_white,
      bishop_red,
      knight_red,
      knight_red_2,
      bishop_white_2,
      queen_red,
      bishop_red_2,
      knight_white_2
    ] }
    let(:board_moved_all_blocked_all) { [
      king_white,
      king_red,
      moved_rook_white_left,
      moved_rook_white_right,
      moved_rook_red_left,
      moved_rook_red_right,
      knight_white,
      queen_white,
      bishop_red,
      bishop_white_2,
      queen_red,
      knight_white_2
    ] }

    let(:board_in_check) {[
      king_white,
      unmoved_rook_white_left,
      unmoved_rook_white_right,
      rook_check,
      knight_check
    ]}

    context 'when the paths to the rook is unblocked and the King is not in check' do
      context 'when the king and rooks have not moved' do
        before do
          allow(king_white).to receive(:remove_castling)
          allow(king_red).to receive(:remove_castling)
        end

        it 'two moves are added to possible_moves' do
          king_white.possible_moves = [
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 5],
            [7, 3]
          ]
          king_white.add_castling(board_unmoved_all_unblocked)
          expect(king_white.possible_moves).to eq([
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 5],
            [7, 3],
            '[0-0-0]',
            '[0-0]'
          ])

          king_red.possible_moves = [
            [0, 5],
            [1, 5],
            [1, 4],
            [1, 3],
            [0, 3]
          ]
          king_red.add_castling(board_unmoved_all_unblocked)
          expect(king_red.possible_moves).to eq([
            [0, 5],
            [1, 5],
            [1, 4],
            [1, 3],
            [0, 3],
            '[0-0-0]',
            '[0-0]'
          ])  
        end
      end

      context 'when the king has not moved' do
        before do
          allow(king_white).to receive(:remove_castling)
          allow(king_red).to receive(:remove_castling)
        end

        it 'no moves are added to possible_moves' do
          king_white.possible_moves = [
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 5],
            [7, 3]
          ]
          king_white.add_castling(board_unmoved_king_unblocked)
          expect(king_white.possible_moves).to eq([
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 5],
            [7, 3]
          ])

          king_red.possible_moves = [
            [1, 5],
            [1, 4],
            [1, 3],
            [0, 3]
          ]
          king_red.add_castling(board_unmoved_king_unblocked)
          expect(king_red.possible_moves).to eq([
            [1, 5],
            [1, 4],
            [1, 3],
            [0, 3]
          ])
        end
      end

      context 'when the king and one rook has not moved' do
        before do
          allow(king_white).to receive(:remove_castling)
          allow(king_red).to receive(:remove_castling)
        end

        it 'one move is added to possible_moves' do
          king_white.possible_moves = [
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 5],
            [7, 3]
          ]
          king_white.add_castling(board_unmoved_king_one_rook_unblocked) 
          expect(king_white.possible_moves).to eq([
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 5],
            [7, 3],
            '[0-0-0]'
          ])

          king_red.possible_moves = [
            [0, 5],
            [1, 5],
            [1, 4],
            [1, 3],
            [0, 3]
          ]
          king_red.add_castling(board_unmoved_king_one_rook_unblocked)
          expect(king_red.possible_moves).to eq([
            [0, 5],
            [1, 5],
            [1, 4],
            [1, 3],
            [0, 3],
            '[0-0]'
          ])
        end
      end

      context 'when the rooks have not moved and the king has' do
        before do
          allow(king_white).to receive(:remove_castling)
          allow(king_red).to receive(:remove_castling)
        end

        it 'no moves are added to possible_moves' do
          king_white.update_position([7, 4])
          king_white.possible_moves = [
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 5],
            [7, 3]
          ]
          king_white.add_castling(board_unmoved_rooks_unblocked) 
          expect(king_white.possible_moves).to eq([
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 5],
            [7, 3]
          ])

          king_red.update_position([0, 4])
          king_red.possible_moves = [
            [0, 5],
            [1, 5],
            [1, 4],
            [1, 3],
            [0, 3]
          ]
          king_red.add_castling(board_unmoved_rooks_unblocked) 
          expect(king_red.possible_moves).to eq([
            [0, 5],
            [1, 5],
            [1, 4],
            [1, 3],
            [0, 3]
          ])
        end
      end

      context 'when the rooks and the king have moved' do
        before do
          allow(king_white).to receive(:remove_castling)
          allow(king_red).to receive(:remove_castling)
        end

        it 'no moves are added to possible_moves' do
          king_white.update_position([7, 4])
          king_white.possible_moves = [
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 5],
            [7, 3]
          ]
          king_white.add_castling(board_unmoved_rooks_unblocked) 
          expect(king_white.possible_moves).to eq([
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 5],
            [7, 3]
          ])

          king_red.update_position([0, 4])
          king_red.possible_moves = [
            [1, 5],
            [1, 4],
            [1, 3],
            [0, 3]
          ]
          king_red.add_castling(board_unmoved_rooks_unblocked) 
          expect(king_red.possible_moves).to eq([
            [1, 5],
            [1, 4],
            [1, 3],
            [0, 3]
          ])
        end
      end
    end

    context 'when the paths to some of the rooks are partially blocked and the King is not in check' do
      context 'when the king and rooks have not moved' do
        before do
          allow(king_white).to receive(:remove_castling)
          allow(king_red).to receive(:remove_castling)
        end

        it 'no moves are added to possible_moves' do
          king_white.possible_moves = [
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 3]
          ]
          king_white.add_castling(board_unmoved_all_blocked_partial)
          expect(king_white.possible_moves).to eq([
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 3]
          ])

          king_red.possible_moves = [
            [1, 5],
            [1, 4],
            [1, 3]
          ] 
          king_red.add_castling(board_unmoved_all_blocked_partial)
          expect(king_red.possible_moves).to eq([
            [1, 5],
            [1, 4],
            [1, 3]
          ])
        end
      end

      context 'when the king has not moved' do
        before do
          allow(king_white).to receive(:remove_castling)
          allow(king_red).to receive(:remove_castling)
        end

        it 'no moves are added to possible_moves' do
          king_white.possible_moves = [
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 3]
          ]
          king_white.add_castling(board_unmoved_king_blocked_partial)
          expect(king_white.possible_moves).to eq([
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 3]
          ])
          
          king_red.possible_moves = [
            [1, 5],
            [1, 4],
            [1, 3]
          ]
          king_red.add_castling(board_unmoved_king_blocked_partial)
          expect(king_red.possible_moves).to eq([
            [1, 5],
            [1, 4],
            [1, 3]
          ])
        end
      end

      context 'when the king and one rook has not moved' do
        before do
          allow(king_white).to receive(:remove_castling)
          allow(king_red).to receive(:remove_castling)
        end

        it 'no moves are added to possible_moves' do
          king_white.possible_moves = [
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 3]
          ]
          king_white.add_castling(board_unmoved_king_one_rook_blocked_partial)
          expect(king_white.possible_moves).to eq([
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 3]
          ])

          king_red.possible_moves = [
            [1, 5],
            [1, 4],
            [1, 3]
          ]
          king_red.add_castling(board_unmoved_king_one_rook_blocked_partial)
          expect(king_red.possible_moves).to eq([
            [1, 5],
            [1, 4],
            [1, 3]
          ])
        end
      end

      context 'when the rooks have not moved and the king has' do
        before do
          allow(king_white).to receive(:remove_castling)
          allow(king_red).to receive(:remove_castling)
        end

        it 'no moves are added to possible_moves' do
          king_white.update_position([7, 4])
          king_white.possible_moves = [
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 3]
          ]
          king_white.add_castling(board_unmoved_rooks_blocked_partial)
          expect(king_white.possible_moves).to eq([
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 3]
          ])

          king_red.update_position([0, 4])
          king_red.possible_moves = [
            [1, 5],
            [1, 4],
            [1, 3]
          ]
          expect(king_red.possible_moves).to eq([
            [1, 5],
            [1, 4],
            [1, 3]
          ])
        end
      end

      context 'when the rooks and the king have moved' do
        before do
          allow(king_white).to receive(:remove_castling)
          allow(king_red).to receive(:remove_castling)
        end

        it 'no moves are added to possible_moves' do
          king_white.update_position([7, 4])
          king_white.possible_moves = [
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 3]
          ]
          king_white.add_castling(board_moved_all_blocked_partial)
          expect(king_white.possible_moves).to eq([
            [6, 3],
            [6, 4],
            [6, 5],
            [7, 3]
          ])

          king_red.update_position([0, 4])
          king_red.possible_moves = [
            [1, 5],
            [1, 4],
            [1, 3]
          ]
          king_red.add_castling(board_moved_all_blocked_partial)
          expect(king_red.possible_moves).to eq([
            [1, 5],
            [1, 4],
            [1, 3]
          ])
        end
      end
    end

    context 'when the paths to the rooks are completely blocked and the King is not in check' do
      context 'when the king and rooks have not moved' do
        before do
          allow(king_white).to receive(:remove_castling)
          allow(king_red).to receive(:remove_castling)
        end

        it 'two moves are added to possible_moves' do
          king_white.possible_moves = [
            [6, 3],
            [6, 4],
            [6, 5]
          ]
          king_white.add_castling(board_unmoved_all_blocked_all)
          expect(king_white.possible_moves).to eq([
            [6, 3],
            [6, 4],
            [6, 5]
          ])
          
          king_red.possible_moves = [
            [1, 5],
            [1, 4],
            [1, 3]
          ]
          king_red.add_castling(board_unmoved_all_blocked_all)
          expect(king_red.possible_moves).to eq([
            [1, 5],
            [1, 4],
            [1, 3]
          ])
        end
      end

      context 'when the king has not moved' do
        before do
          allow(king_white).to receive(:remove_castling)
          allow(king_red).to receive(:remove_castling)
        end

        it 'no moves are added to possible_moves' do
          king_white.possible_moves = [
            [6, 3],
            [6, 4],
            [6, 5]
          ]
          king_white.add_castling(board_unmoved_king_blocked_all)
          expect(king_white.possible_moves).to eq([
            [6, 3],
            [6, 4],
            [6, 5]
          ])

          king_red.possible_moves = [
            [1, 5],
            [1, 4],
            [1, 3]
          ]
          king_red.add_castling(board_unmoved_king_blocked_all)
          expect(king_red.possible_moves).to eq([
            [1, 5],
            [1, 4],
            [1, 3]
          ])
        end
      end

      context 'when the king and one rook has not moved' do
        before do
          allow(king_white).to receive(:remove_castling)
          allow(king_red).to receive(:remove_castling)
        end

        it 'one move is added to possible_moves' do
          king_white.possible_moves = [
            [6, 3],
            [6, 4],
            [6, 5]
          ]
          king_white.add_castling(board_unmoved_king_one_rook_blocked_all)
          expect(king_white.possible_moves).to eq([
            [6, 3],
            [6, 4],
            [6, 5]
          ])
          
          king_red.possible_moves = [
            [1, 5],
            [1, 4],
            [1, 3]
          ]
          king_red.add_castling(board_unmoved_king_one_rook_blocked_all)
          expect(king_red.possible_moves).to eq([
            [1, 5],
            [1, 4],
            [1, 3]
          ])
        end
      end

      context 'when the rooks have not moved and the king has' do
        before do
          allow(king_white).to receive(:remove_castling)
          allow(king_red).to receive(:remove_castling)
        end

        it 'no moves are added to possible_moves' do
          king_white.update_position([7, 4])
          king_white.possible_moves = [
            [6, 3],
            [6, 4],
            [6, 5]
          ]
          king_white.add_castling(board_unmoved_rooks_blocked_all)
          expect(king_white.possible_moves).to eq([
            [6, 3],
            [6, 4],
            [6, 5]
          ])
          
          king_red.update_position([0, 4])
          king_red.possible_moves = [
            [1, 5],
            [1, 4],
            [1, 3]
          ]
          king_red.add_castling(board_unmoved_rooks_blocked_all)
          expect(king_red.possible_moves).to eq([
            [1, 5],
            [1, 4],
            [1, 3]
          ])
        end
      end
      context 'when the rooks and the king have moved' do
        before do
          allow(king_white).to receive(:remove_castling)
          allow(king_red).to receive(:remove_castling)
        end
        
        it 'no moves are added to possible_moves' do
          king_white.update_position([7, 4])
          king_white.possible_moves = [
            [6, 3],
            [6, 4],
            [6, 5]
          ]
          king_white.add_castling(board_moved_all_blocked_all)
          expect(king_white.possible_moves).to eq([
            [6, 3],
            [6, 4],
            [6, 5]
          ])
          
          king_red.update_position([0, 4])
          king_red.possible_moves = [
            [1, 5],
            [1, 4],
            [1, 3]
          ]
          king_red.add_castling(board_moved_all_blocked_all)
          expect(king_red.possible_moves).to eq([
            [1, 5],
            [1, 4],
            [1, 3]
          ])
        end
      end
    end

    context 'when the paths to the rooks are clear but the King is in check' do
      before do
        allow(king_white).to receive(:remove_castling)
      end

      it 'no moves are added to possible_moves' do
         king_white.possible_moves = [
            [6, 3],
            [6, 5],
            [7, 3]
         ]
         king_white.add_castling(board_in_check)
         expect(king_white.possible_moves).to eq([
            [6, 3],
            [6, 5],
            [7, 3]
         ])
      end
   end
  end
end