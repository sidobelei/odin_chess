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
end