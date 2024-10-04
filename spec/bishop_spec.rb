require_relative '../lib/bishop'

describe Bishop do
  describe '#initialize' do
    subject(:bishop) { described_class.new('red', [7, 2])}

    context 'when a Bishop object is initialized' do
      it 'assigns a color attribute' do
        expect(bishop.color).to eq('red')    
      end

      it 'assigns a name attribute' do
        expect(bishop.name).to eq("\e[1m\e[31mB\e[0m")
      end

      it 'assigns a type attribute' do
        expect(bishop.type).to eq("bishop")
      end

      it 'assigns a position attribute' do
        expect(bishop.position).to eq([7, 2])
      end
    end
  end
  
  describe '#out_of_bounds?' do
    subject(:in_bounds) { described_class.new('white', [7, 5] )}
    subject(:out_bounds) { described_class.new('red', [0, 2]) }
    context 'when given a position that is not out of bounds of the board' do
      it 'returns false' do
        expect(in_bounds.out_of_bounds?([7, 0])).to eq(false)
        expect(in_bounds.out_of_bounds?([7, 7])).to eq(false)
        expect(in_bounds.out_of_bounds?([0, 7])).to eq(false)
        expect(in_bounds.out_of_bounds?([0, 0])).to eq(false)
        expect(in_bounds.out_of_bounds?([4, 3])).to eq(false)
      end
    end

    context 'when given a position that is out of bounds' do
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