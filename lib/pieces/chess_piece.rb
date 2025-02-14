require_relative '../chess_utilities'

class ChessPiece 
  include ChessUtilites
  
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
    
    valid_range = [0, 1, 2, 3, 4, 5, 6, 7, nil]
    if position.length == 2 && valid_range.include?(position[0]) && valid_range.include?(position[1])
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
end