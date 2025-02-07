require_relative '../lib/chess_utilities'
require_relative '../lib/king'
require_relative '../lib/pawn'
require_relative '../lib/rook'
require_relative '../lib/knight'
require_relative '../lib/bishop'
require_relative '../lib/queen'

describe ChessUtilites do
  describe '#out_of_bounds' do
    context 'when given a position that is not out of bounds of the board' do
      class InBoundsDummy
        include ChessUtilites
      end

      let(:in_bounds) { InBoundsDummy.new }
      it 'returns false' do
        expect(in_bounds.out_of_bounds?([7, 0])).to eq(false)
        expect(in_bounds.out_of_bounds?([7, 7])).to eq(false)
        expect(in_bounds.out_of_bounds?([0, 7])).to eq(false)
        expect(in_bounds.out_of_bounds?([0, 0])).to eq(false)
        expect(in_bounds.out_of_bounds?([4, 3])).to eq(false)
      end
    end

    context 'when given a position that is out of bounds' do
      class OutBoundsDummy
        include ChessUtilites
      end

      let(:out_bounds) { OutBoundsDummy.new }

      it 'returns true' do
        expect(out_bounds.out_of_bounds?([-1, 7])).to eq(true)
        expect(out_bounds.out_of_bounds?([-1, 0])).to eq(true)
        expect(out_bounds.out_of_bounds?([8, 0])).to eq(true)
        expect(out_bounds.out_of_bounds?([8, 7])).to eq(true)
        expect(out_bounds.out_of_bounds?([-100, 800])).to eq(true)
      end
    end
  end

  describe '#in_check' do
    let(:in_check_king) { King.new('red', [2, 6]) }
    let(:pawn_check) { Pawn.new('white', [3, 7]) }
    let(:rook_check) { Rook.new('white', [2, 3]) }
    let(:knight_check) { Knight.new('white', [4, 5]) }
    let(:bishop_check) { Bishop.new('white', [1, 7]) }
    let(:queen_check) { Queen.new('white', [0, 6]) }
    let(:noncheck_knight) { Knight.new('red', [0, 3]) }
    let(:noncheck_rook) { Rook.new('white', [3, 5]) }
    let(:noncheck_bishop) { Bishop.new('red', [7, 2]) }
    let(:noncheck_queen) { Queen.new('white', [7, 7]) }
    let(:noncheck_pawn) { Pawn.new('white', [2, 6]) }
    let(:moving_rook) { Rook.new('red', [2, 5]) }

    let(:board_no_check) { [
      in_check_king,
      noncheck_knight,
      noncheck_rook,
      noncheck_bishop,
      noncheck_queen
    ] }
    let(:board_one_check) { [
      in_check_king,
      knight_check,
      noncheck_knight,
      noncheck_rook,
      noncheck_bishop,
      noncheck_queen
    ] }
    let(:board_multi_check) { [
      in_check_king,
      pawn_check,
      rook_check,
      bishop_check,
      knight_check,
      queen_check
    ] }
    let(:board_capture_check) { [
      in_check_king,
      noncheck_pawn,
      knight_check
    ] }
    let(:board_moved_check) { [
      in_check_king,
      rook_check,
      moving_rook
    ] }

    context 'when the King is not in check' do
      before do
        in_check_king.possible_moves = [[3, 5]]
        noncheck_knight.possible_moves = [[2, 4]]
        noncheck_rook.possible_moves = [[2, 5]]
        noncheck_bishop.possible_moves = [[3, 6]]
        noncheck_queen.possible_moves = [[2, 7]]
      end
      
      it 'returns false' do
        expect(in_check_king.in_check?(board_no_check, [2, 6])).to eq(false)
      end
    end

    context 'when the King is in check by one chess piece' do
      before do
        in_check_king.possible_moves = [[3, 5]]
        knight_check.possible_moves = [[2, 6]]
        noncheck_knight.possible_moves = [[2, 2]]
        noncheck_rook.possible_moves = [[3, 7]]
        noncheck_bishop.possible_moves = [[3, 6]]
        noncheck_queen.possible_moves = [[7, 6]]
      end
      it 'returns true' do
        expect(in_check_king.in_check?(board_one_check, [2, 6])).to eq(true)
      end
    end

    context 'when the King is in check by multiple pieces' do
      before do
        in_check_king.possible_moves = []
        pawn_check.possible_moves = [[2, 6]]
        rook_check.possible_moves = [[2, 6]]
        bishop_check.possible_moves = [[2, 6]]
        knight_check.possible_moves = [[2, 6]]
        queen_check.possible_moves = [[2, 6]]
      end
      it 'returns true' do
        expect(in_check_king.in_check?(board_multi_check, [2, 6])).to eq(true)
      end
    end

    context 'when the King captures a piece that puts itself in check' do
      before do
        in_check_king.update_position([1, 6])
        in_check_king.possible_moves = [[2, 6]]
        noncheck_pawn.possible_moves = []
        knight_check.possible_moves = [[2, 6]]
      end
      
      it 'returns true' do
        expect(in_check_king.in_check?(board_capture_check, [1, 6])).to eq(false)
        expect(in_check_king.in_check?(board_capture_check, [2, 6])).to eq(true)
      end
    end

    context "when a piece tries to move but it would place it's King in check" do
      before do
        in_check_king.possible_moves = [[1, 6]]
        rook_check.possible_moves = [[1, 5]]
        moving_rook.possible_moves = [2, 4]
      end
      
      it 'returns true' do
        expect(moving_rook.in_check?(board_moved_check, [2, 5])).to eq(false)
        expect(moving_rook.in_check?(board_moved_check, [1, 5])).to eq(true)
      end
    end
  end
end