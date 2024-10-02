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

      it 'assigns a position attribute' do
        expect(bishop.position).to eq([7, 2])
      end

      it 'calls update_possible_moves' do
        allow_any_instance_of(Bishop).to receive(:update_possible_moves)
        Bishop.new('red', [7,2])
      end
    end
  end
end