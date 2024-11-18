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
end 