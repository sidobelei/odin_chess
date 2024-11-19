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

  describe '#get_input' do
    subject(:invalid_inputs) { described_class.new }
    subject(:invalid_input_valid_input) { described_class.new }
    subject(:valid_input_invalid_input) { described_class.new }
    subject(:invalid_position) { described_class.new }
    subject(:invalid_new_position) { described_class.new }
    subject(:valid_inputs) { described_class.new }
    subject(:valid_castling_kingside) { described_class.new } 
    subject(:valid_castling_queenside) { described_class.new } 

    before do
      allow(invalid_inputs).to receive(:gets).and_return("u3, a0")
      allow(invalid_input_valid_input).to receive(:gets).and_return("m10, a6")
      allow(valid_input_invalid_input).to receive(:gets).and_return("g7, t2")
      allow(invalid_position).to receive(:gets).and_return("c8, f3")      
      allow(invalid_new_position).to receive(:gets).and_return("h7, d1")
      allow(valid_inputs).to receive(:puts)
      allow(valid_inputs).to receive(:gets).and_return("e2, e4")
      allow(valid_castling_kingside).to receive(:puts)
      allow(valid_castling_kingside).to receive(:gets).and_return("e1, 0-0")
      allow(valid_castling_queenside).to receive(:puts)
      allow(valid_castling_queenside).to receive(:gets).and_return("e1, 0-0-0")  
    end
    
    context 'when coordinates have invalid characters' do
      it 'returns Invalid Input message' do
        invalid_inputs.board.update_pieces
        player = invalid_inputs.player_1
        expect{ invalid_inputs.get_input(player) }.to output("#{player.color.capitalize}'s Turn: \nInvalid Input\n\n").to_stdout
      end  
    end

    context 'when one of the coordinates has invalid characters' do
      it 'returns Invalid Input message' do
        invalid_input_valid_input.board.update_pieces
        iivi_player = invalid_input_valid_input.player_2
        valid_input_invalid_input.board.update_pieces
        viii_player = valid_input_invalid_input.player_2
        expect{ invalid_input_valid_input.get_input(iivi_player) }.to output("#{iivi_player.color.capitalize}'s Turn: \nInvalid Input\n\n").to_stdout
        expect{ valid_input_invalid_input.get_input(viii_player) }.to output("#{viii_player.color.capitalize}'s Turn: \nInvalid Input\n\n").to_stdout
      end
    end

    context 'when the position coordinate is invalid' do
      it 'returns Invalid Input message' do
        invalid_position.board.update_pieces
        player = invalid_position.player_1
        expect{ invalid_position.get_input(player) }.to output("#{player.color.capitalize}'s Turn: \nInvalid Input\n\n").to_stdout
      end
    end

    context 'when the new position coordinate is invalid' do
      it 'returns Invalid Input message' do
        invalid_new_position.board.update_pieces
        player = invalid_new_position.player_2
        expect{ invalid_new_position.get_input(player) }.to output("#{player.color.capitalize}'s Turn: \nInvalid Input\n\n").to_stdout
      end
    end

    context 'when both coordinates are valid' do
      it 'returns the ' do
        valid_inputs.board.update_pieces
        player = valid_inputs.player_1
        expect(valid_inputs.get_input(player)).to eq([[6, 4], [4, 4]])

        valid_castling_kingside.board.display.each do |piece|
          if piece.type == 'king' || piece.type == 'rook' || piece.type == 'pawn'
            next
          else
            piece.position = [nil, nil]
          end
        end
        valid_castling_kingside.board.update_pieces
        castling_player_kingside = valid_castling_kingside.player_1
        expect(valid_castling_kingside.get_input(castling_player_kingside)).to eq([[7, 4], ['0-0']])

        valid_castling_queenside.board.display.each do |piece|
          if piece.type == 'king' || piece.type == 'rook' || piece.type == 'pawn'
            next
          else
            piece.position = [nil, nil]
          end
        end
        valid_castling_queenside.board.update_pieces
        castling_player_queenside = valid_castling_queenside.player_1
        expect(valid_castling_queenside.get_input(castling_player_queenside)).to eq([[7, 4], ['0-0-0']])
      end      
    end
  end
end 