require_relative '../lib/queen'

describe Queen do
  describe '#initialize' do
    context 'when a Queen object is initialized' do
      subject(:queen) { described_class.new('red', [3, 4])}

        it 'assigns a color attribute' do
          expect(queen.color).to eq('red')    
        end
  
        it 'assigns a name attribute' do
          expect(queen.name).to eq("\e[1m\e[31mQ\e[0m")
        end
  
        it 'assigns a type attribute' do
          expect(queen.type).to eq("queen")
        end
  
        it 'assigns a position attribute' do
          expect(queen.position).to eq([3, 4])
        end
    end
  end
end