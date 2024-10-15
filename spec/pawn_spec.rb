require_relative '../lib/pawn'

describe Pawn do
  describe '#initialize' do
    subject(:pawn) { described_class.new('white', [4, 4]) }
    
    context 'when a Pawn object is initialized' do
      xit 'assigns a color attribute' do
        expect(pawn.color).to eq('white')
      end
      
      xit 'assigns a name attribute' do
        expect(pawn.name).to eq('\e[1m\e[37mP\e[0m')
      end
      
      xit 'assigns a type attribute' do
        expect(pawn.type).to eq('pawn')
      end
      
      xit 'assigns a position attribute' do
        expect(pawn.position).to eq([4, 4])
      end
      
      xit 'assigns false to the moved attribute' do
        expect(pawn.moved).to eq(false)
      end
      
      xit 'assigns false to the promoted attribute' do
        expect(pawn.promoted).to eq(false)
      end
    end
  end
end