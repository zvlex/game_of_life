require 'gosu'
require 'gosu/all'

require_relative './game_of_life/cell_table'
require_relative './game_of_life/patterns'
require_relative './game_of_life/grid_cell'
require_relative './game_of_life/game_world'

#
module GameOfLife
  window = GameWorld.new
  window.show
end
