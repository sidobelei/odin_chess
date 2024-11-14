class Player
  attr_accessor :color, :my_pieces, :inputs
  def initialize(color, pieces)
    @color = color
    @my_pieces = pieces
    @inputs = []
  end

  def convert_to_coords(str)
    conversion_table = {
      'a' => 0, 
      'b' => 1, 
      'c' => 2, 
      'd' => 3, 
      'e' => 4, 
      'f' => 5, 
      'g' => 6, 
      'h' => 7,
      '8' => 0, 
      '7' => 1, 
      '6' => 2, 
      '5' => 3, 
      '4' => 4, 
      '3' => 5, 
      '2' => 6, 
      '1' => 7
    }
    pos = []
    new_pos = []

    coordinates = str.downcase.split(',')
    unconverted_pos = coordinates[0].split('')
    unconverted_pos.each do |position|
      pos.unshift(conversion_table.fetch(position))
    end

    unconverted_new_pos = coordinates[1].strip
    if unconverted_new_pos == '0-0-0' || unconverted_new_pos == '0-0'
      new_pos << unconverted_new_pos
    else
      unconverted_new_pos = unconverted_new_pos.split('')
      unconverted_new_pos.each do |position|
        new_pos.unshift(conversion_table.fetch(position))
      end
    end
    return pos, new_pos
  end

  def valid_move?(pos, new_pos)  
    my_pieces.each do |piece|
      if piece.position == pos
        piece.possible_moves.each do |move|
          if new_pos == move
            return true
          end 
        end
      end
    end
    return false
  end
end