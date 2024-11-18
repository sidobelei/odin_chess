require_relative '../lib/game'

describe Game do
  describe '#initialize' do
    subject(:game) { described_class.new }
    
    context 'when a new Game object is initialized' do
      it 'creates a new board object' do
        expect(game.board).to be_a(Board)
      end

      it 'creates two player objects' do
        expect(game.player_1).to be_a(Player)
        expect(game.player_2).to be_a(Player)
      end
    end
  end

  describe 'convert_to_coords' do
    subject(:game) { described_class.new }
    
    context 'when a regular move is made' do
      it 'converts the string to the correct position and new location' do
        expect(game.convert_to_coords('e1, d2')).to eq([[7, 4], [6, 3]])
      end
    end

    context 'when a castling move is made' do
      it 'converts the string to the correct position and new location' do
        expect(game.convert_to_coords('e1, 0-0-0')).to eq([[7, 4], ['0-0-0']])
        expect(game.convert_to_coords('e1, 0-0')).to eq([[7, 4], ['0-0']])
      end
    end
  end
end 