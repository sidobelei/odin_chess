class Player
  attr_accessor :color, :my_pieces, :inputs
  def initialize(color, pieces)
    @color = color
    @my_pieces = pieces
    @inputs = []
  end
end