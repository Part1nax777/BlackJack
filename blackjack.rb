require_relative 'game.rb'

game = Game.new
game.start_game

loop { game.process_turn }
