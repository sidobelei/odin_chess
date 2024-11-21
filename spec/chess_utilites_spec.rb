require_relative '../lib/chess_utilities'

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
    class KingDummy
      include ChessUtilites
      
      attr_accessor :color, :position, :type, :possible_moves

      def initialize
        @color = 'red'
        @position = [2, 6]
        @type = 'king'
        @possible_moves = []  
      end
    end
    
    let(:in_check_king) { KingDummy.new }
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
end