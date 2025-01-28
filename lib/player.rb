class Player
  attr_accessor :color, :my_pieces, :inputs, :check_status

  def initialize(color, pieces)
    @color = color
    @my_pieces = pieces
    @inputs = []
    @check_status = false
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

  def self_check
    king_status = my_pieces.find {|piece| piece.type == 'king'}.check_status
    if king_status == true
      @check_status = true
    else
      @check_status = false
    end 
  end

  def to_json(*args)
    {
      'color' => @color,
      'inputs' => @inputs,
      'check_status' => @check_status
    }.to_json
  end

  def from_json(args)
    self.instance_variable_set("@inputs", args['inputs'])
    self.instance_variable_set("@check_status", args['check_status'])
  end
end