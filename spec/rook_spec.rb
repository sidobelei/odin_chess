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
      
      it 'assigns false to the moved attribute' do
        expect(rook.moved).to eq(false)
      end
    end
  end  
end