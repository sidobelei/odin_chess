require_relative '../lib/chess_piece'

describe ChessPiece do
  describe '#initialize' do
    subject(:chess_piece_red) { described_class.new("ReD", "N", [0, 6] ) }
    subject(:chess_piece_white) {described_class.new("whIte", "P", [5, 2]) }
    
    context 'when ChessPiece object is initialized' do
      context 'when the color is either red or white'
      it 'assigns a color to the color attribute' do
        expect(chess_piece_red.color).to eq("red")
        expect(chess_piece_white.color).to eq("white")
      end
      
      it "assigns a name to the name attribute" do
        expect(chess_piece_red.name).to eq("\e[1m\e[31mN\e[0m")
        expect(chess_piece_white.name).to eq("\e[1m\e[37mP\e[0m")
      end

      it 'creates an empty array for possible_moves' do
        expect(chess_piece_red.possible_moves).to eq([])
        expect(chess_piece_white.possible_moves).to eq([])
      end

      it 'assigns coordinates to the position attribute' do
        expect(chess_piece_red.position).to eq([0, 6])
        expect(chess_piece_white.position).to eq([5, 2])
      end

      it 'calls update_possible_moves' do
        expect_any_instance_of(described_class).to receive(:update_possible_moves)
        described_class.new("ReD", "N", [0, 6])
      end

      subject(:invalid_color_piece) { described_class.new("green", "K", [0, 0]) }
      subject(:invalid_position_piece) { described_class.new("red", "K", [-1, 7]) }
      subject(:invalid_position_piece2) { described_class.new("red", "K", [0, 70]) }
      context 'when given invalid inputs' do
        it 'raises an error for an invalid color input' do
          expect { invalid_color_piece }.to raise_error(ArgumentError, 'Invalid color input')
        end

        it 'raises an error for an invalid coordinates input' do
          expect { invalid_position_piece }.to raise_error(ArgumentError, 'Invalid coordinates input')
          expect { invalid_position_piece2 }.to raise_error(ArgumentError, 'Invalid coordinates input')
        end
      end
    end
  end

  describe '#update_position' do
    subject(:old_position) { described_class.new('red', 'B', [7, 2]) }
    
    before do
      allow(old_position).to receive(:update_possible_moves)
    end
    
    context 'when a new chess position is given' do
      it 'updates the current position of the chess piece' do
        expect { old_position.update_position([5,3]) }.to change { old_position.position }.to([5, 3])
      end

      it 'calls the update_possible_moves method' do
        expect(old_position).to receive(:update_possible_moves)
        old_position.update_position([5, 3])
      end
    end
  end
end