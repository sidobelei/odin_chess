class ChessPiece 
  attr_accessor :color, :name, :position, :possible_moves, :type

  def initialize(color, name, type, position)
    color = color.downcase
    if color == "red" || color == "white"
      @color = color
    else
      raise ArgumentError, "Invalid color input"
    end

    if color == "red"
      @name ="\e[1m\e[31m#{name}\e[0m"
    elsif color == "white"
      @name = "\e[1m\e[37m#{name}\e[0m"
    end

    @type = type
    @possible_moves = []
    
    if position.length == 2 && Array(0..7).include?(position[0]) && Array(0..7).include?(position[1])
      @position = position
    else
      raise ArgumentError, "Invalid coordinates input"
    end
  end

  def update_position(new_position)
    @position = new_position
  end

  def update_possible_moves(board)
    puts 'Will update possible_moves in subclass'
  end

  def out_of_bounds?(pos)
    pos[0] > 7 || pos[0] < 0 || pos[1] > 7 || pos[1] < 0
  end
end