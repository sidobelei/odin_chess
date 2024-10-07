require_relative '../lib/knight'

describe Knight do
  describe '#initialize' do
    subject(:knight) { described_class.new('white', [0, 6]) }

    context 'when a Knight object is initialized' do
      it 'assigns a color attribute' do
        expect(knight.color).to eq('white') 
      end

      it 'assigns a name attribute' do
        expect(knight.name).to eq("\e[1m\e[37mN\e[0m")
      end

      it 'assigns a type attribute' do
        expect(knight.type).to eq('knight')
      end

      it 'assigns a position attribute' do
        expect(knight.position).to eq([0, 6])
      end
    end
  end
end