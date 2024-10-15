require_relative '../lib/pawn'

describe Pawn do
  describe '#initialize' do
    subject(:pawn) { described_class.new('white', [4, 4]) }
    
    context 'when a Pawn object is initialized' do
      it 'assigns a color attribute' do
        expect(pawn.color).to eq('white')
      end
      
      it 'assigns a name attribute' do
        expect(pawn.name).to eq("\e[1m\e[37mP\e[0m")
      end
      
      it 'assigns a type attribute' do
        expect(pawn.type).to eq('pawn')
      end
      
      it 'assigns a position attribute' do
        expect(pawn.position).to eq([4, 4])
      end
      
      it 'assigns false to the moved attribute' do
        expect(pawn.moved).to eq(false)
      end
      
      it 'assigns false to the promoted attribute' do
        expect(pawn.promoted).to eq(false)
      end
    end
  end

  describe '#update_position' do
    subject(:default_pawn) { described_class.new('red', [2, 7]) }
    subject(:moved_pawn) { described_class.new('white', [4, 4]) }
    subject(:white_pawn1) { described_class.new('white', [1, 0]) }
    subject(:white_pawn2) { described_class.new('white', [1, 1]) }
    subject(:white_pawn3) { described_class.new('white', [1, 2]) }
    subject(:white_pawn4) { described_class.new('white', [1, 3]) }
    subject(:white_pawn5) { described_class.new('white', [1, 4]) }
    subject(:white_pawn6) { described_class.new('white', [1, 5]) }
    subject(:white_pawn7) { described_class.new('white', [1, 6]) }
    subject(:white_pawn8) { described_class.new('white', [1, 7]) }
    subject(:red_pawn1) { described_class.new('red', [6, 0]) }
    subject(:red_pawn2) { described_class.new('red', [6, 1]) }
    subject(:red_pawn3) { described_class.new('red', [6, 2]) }
    subject(:red_pawn4) { described_class.new('red', [6, 3]) }
    subject(:red_pawn5) { described_class.new('red', [6, 4]) }
    subject(:red_pawn6) { described_class.new('red', [6, 5]) }
    subject(:red_pawn7) { described_class.new('red', [6, 6]) }
    subject(:red_pawn8) { described_class.new('red', [6, 7]) }

    context 'when the Pawn has not reached the other end of the board and has not been moved' do
      it 'updates its current position and changes moved attribute to true' do
        expect(default_pawn.position).to eq([2, 7])
        expect(default_pawn.moved).to eq(false)
        default_pawn.update_position([4, 7])
        expect(default_pawn.position).to eq([4, 7])
        expect(default_pawn.moved).to eq(true)
      end
    
    end
    
    context 'when the Pawn has not reached the other end of the board and has moved' do
      it 'updates its current position and the moved attribute is still true' do
        expect(moved_pawn.position).to eq([4, 4])
        moved_pawn.update_position([5, 4])
        expect(moved_pawn.position).to eq([5, 4])
      end
    end

    context 'when the Pawn has reached the other end of the board' do
      it 'updates its position to nil and changes the promoted attribute to true' do
        white_pawn1.update_position([0, 0])
        white_pawn2.update_position([0, 1])
        white_pawn3.update_position([0, 2])
        white_pawn4.update_position([0, 3])
        white_pawn5.update_position([0, 4])
        white_pawn6.update_position([0, 5])
        white_pawn7.update_position([0, 6])
        white_pawn8.update_position([0, 7])
        red_pawn1.update_position([7, 0])
        red_pawn2.update_position([7, 1])
        red_pawn3.update_position([7, 2])
        red_pawn4.update_position([7, 3])
        red_pawn5.update_position([7, 4])
        red_pawn6.update_position([7, 5])
        red_pawn7.update_position([7, 6])
        red_pawn8.update_position([7, 7])
        expect(white_pawn1.position).to eq(nil)
        expect(white_pawn1.promoted).to eq(true)
        expect(white_pawn2.position).to eq(nil)
        expect(white_pawn2.promoted).to eq(true)
        expect(white_pawn3.position).to eq(nil)
        expect(white_pawn3.promoted).to eq(true)
        expect(white_pawn4.position).to eq(nil)
        expect(white_pawn4.promoted).to eq(true)
        expect(white_pawn5.position).to eq(nil)
        expect(white_pawn5.promoted).to eq(true)
        expect(white_pawn6.position).to eq(nil)
        expect(white_pawn6.promoted).to eq(true)
        expect(white_pawn7.position).to eq(nil)
        expect(white_pawn7.promoted).to eq(true)
        expect(white_pawn8.position).to eq(nil)
        expect(white_pawn8.promoted).to eq(true)
        expect(red_pawn1.position).to eq(nil)
        expect(red_pawn1.promoted).to eq(true)
        expect(red_pawn2.position).to eq(nil)
        expect(red_pawn2.promoted).to eq(true)
        expect(red_pawn3.position).to eq(nil)
        expect(red_pawn3.promoted).to eq(true)
        expect(red_pawn4.position).to eq(nil)
        expect(red_pawn4.promoted).to eq(true)
        expect(red_pawn5.position).to eq(nil)
        expect(red_pawn5.promoted).to eq(true)
        expect(red_pawn6.position).to eq(nil)
        expect(red_pawn6.promoted).to eq(true)
        expect(red_pawn7.position).to eq(nil)
        expect(red_pawn7.promoted).to eq(true)
        expect(red_pawn8.position).to eq(nil)
        expect(red_pawn8.promoted).to eq(true)
      end
    end
  end
end