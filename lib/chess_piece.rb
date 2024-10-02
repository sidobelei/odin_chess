class ChessPiece 
  attr_accessor :color, :name, :position, :possible_moves

  def initialize(color, name, position)
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

    @possible_moves = []
    
    if position.length == 2 && Array(0..7).include?(position[0]) && Array(0..7).include?(position[1])
      @position = position
      update_possible_moves
    else
      raise ArgumentError, "Invalid coordinates input"
    end
  end

  def update_position(new_position)
    @position = new_position
    update_possible_moves
  end

  def update_possible_moves
    puts 'Will update possible_moves in subclass'
  end
end