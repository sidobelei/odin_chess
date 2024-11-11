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
end