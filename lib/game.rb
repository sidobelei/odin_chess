require_relative 'board'
require_relative 'player'

class Game
  attr_accessor :board, :player_1, :player_2

  def initialize
    @board = Board.new
    @player_1 = Player.new('white', @board.display.select { |piece| piece.color == 'white'})
    @player_2 = Player.new('red', @board.display.select { |piece| piece.color == 'red'})
  end
end