require_relative '../lib/game'

describe Game do
  describe '#initialize' do
    context 'when a new Game object is initialized' do
      it 'creates a new board object' do
        expect(Board).to receive(:new).once
        Game.new
      end
    end
  end
end 