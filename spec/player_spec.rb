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

      it 'assigns false to check_status attribute' do
        expect(new_player.check_status).to eq(false)
      end
    end
  end

  describe '#valid_move?' do
    let(:player_color) { 'red' }
    let(:player_pieces) { [
      double(type: 'king', color: player_color, position: [0, 4], possible_moves: []),
      double(type: 'queen', color: player_color, position: [0, 3], possible_moves: []),
      double(type: 'bishop', color: player_color, position: [0, 2], possible_moves: []),
      double(type: 'bishop', color: player_color, position: [0, 5], possible_moves: []),
      double(type: 'knight', color: player_color, position: [0, 1], possible_moves: [[2, 0], [2, 2]]),
      double(type: 'knight', color: player_color, position: [0, 6], possible_moves: [[2, 5], [2, 7]]),
      double(type: 'rook', color: player_color, position: [0, 0], possible_moves: []),
      double(type: 'rook', color: player_color, position: [0, 7], possible_moves: []),
      double(type: 'pawn', color: player_color, position: [1, 0], possible_moves: [[2, 0], [3, 0]]),
      double(type: 'pawn', color: player_color, position: [1, 1], possible_moves: [[2, 1], [3, 1]]),
      double(type: 'pawn', color: player_color, position: [1, 2], possible_moves: [[2, 2], [3, 2]]),
      double(type: 'pawn', color: player_color, position: [1, 3], possible_moves: [[2, 3], [3, 3]]),
      double(type: 'pawn', color: player_color, position: [1, 4], possible_moves: [[2, 4], [3, 4]]),
      double(type: 'pawn', color: player_color, position: [1, 5], possible_moves: [[2, 5], [3, 5]]),
      double(type: 'pawn', color: player_color, position: [1, 6], possible_moves: [[2, 6], [3, 6]]),
      double(type: 'pawn', color: player_color, position: [1, 7], possible_moves: [[2, 7], [3, 7]])
    ] }
    
    subject(:player) { described_class.new(player_color, player_pieces)}
    
    context 'when there is no chess piece at that position and the move is invalid' do
      it 'returns false' do
        player.my_pieces = player_pieces
        expect(player.valid_move?([7, 4], [4, 2])).to eq(false)
      end
    end

    context 'when there is no chess piece at that position and the move is valid' do
      it 'returns false' do
        player.my_pieces = player_pieces
        expect(player.valid_move?([6, 0], [2, 0])).to eq(false)
      end
    end

    context 'when there is a chess piece at that position but the move is invalid' do
      it 'returns false' do
        player.my_pieces = player_pieces
        expect(player.valid_move?([1, 7], [5, 6])).to eq(false)
        expect(player.valid_move?([0, 4], [3, 5])).to eq(false)
      end
    end

    context 'when there is a chess piece at that position and it is a valid move' do
      it 'returns true' do
        player.my_pieces = player_pieces
        expect(player.valid_move?([0, 6], [2, 7])).to eq(true)
      end
    end
  end

  describe '#self_check' do
    let(:player_color) { 'red' }
    let(:player_pieces_check) { [
      double(type: 'king', color: player_color, check_status: true)
    ] }
    let(:player_pieces_no_check) { [
      double(type: 'king', color: player_color, check_status: false)
    ] }
    subject(:player_in_check) { described_class.new(player_color, player_pieces_check) }
    subject(:player_not_in_check) { described_class.new(player_color, player_pieces_no_check) }
    
    context 'when their King is in check' do
      it 'the check_status attribute is changed to true' do
        player_in_check.self_check
        expect(player_in_check.check_status).to eq(true)
      end
    end

    context 'when their King is not in check' do
      it 'the check_status attribute is false' do
        player_not_in_check.self_check
        expect(player_not_in_check.check_status).to eq(false)
      end
    end
  end
end