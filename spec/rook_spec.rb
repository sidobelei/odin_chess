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

    describe '#update_position' do
      context 'when the Rook was not moved and is called to be moved' do
        subject(:rook_unmoved) { described_class.new('white', [7, 0]) }
        
        it 'updates the current position and changes the moved attribute to true' do
          rook_unmoved.update_position([5, 0])
          expect(rook_unmoved.position).to eq([5, 0])
          expect(rook_unmoved.moved).to eq(true)
        end
      end

      context 'when the Rook was moved previously and is called to be moved again' do
        subject(:rook_moved) { described_class.new('red', [0, 7]) }
        
        it 'updates the current position and moved attribute stays true' do
          expect(rook_moved.moved).to eq(false)
          rook_moved.update_position([0, 6])
          expect(rook_moved.moved).to eq(true)
          rook_moved.update_position([4, 6])
          expect(rook_moved.position).to eq([4, 6])
          expect(rook_moved.moved).to eq(true)
        end
      end
    end
  end  
end