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
end