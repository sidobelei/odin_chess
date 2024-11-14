require_relative '../lib/player'

describe Player do
  describe '#initialize' do
    context 'when a Player object is initialized' do
      let(:player_color) { 'white' }
      let(:player_pieces) { [
        double(type: 'king', color: player_color),
        double(type: 'queen', color: player_color),
        double(type: 'bishop', color: player_color),
        double(type: 'bishop', color: player_color),
        double(type: 'knight', color: player_color),
        double(type: 'knight', color: player_color),
        double(type: 'rook', color: player_color),
        double(type: 'rook', color: player_color),
        double(type: 'pawn', color: player_color),
        double(type: 'pawn', color: player_color),
        double(type: 'pawn', color: player_color),
        double(type: 'pawn', color: player_color),
        double(type: 'pawn', color: player_color),
        double(type: 'pawn', color: player_color),
        double(type: 'pawn', color: player_color),
        double(type: 'pawn', color: player_color)
      ] }
      subject(:new_player) { described_class.new(player_color, player_pieces) }
      it 'assigns a player attribute' do
        expect(new_player.color).to eq(player_color)
      end

      it 'assigns an array to my_pieces attribute' do
        expect(new_player.my_pieces).to eq(player_pieces)
      end

      it 'assigns an empty array to the inputs array' do
        expect(new_player.inputs).to eq([])
      end
    end
  end
end