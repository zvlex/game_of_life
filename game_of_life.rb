require 'pry'
require 'gosu'
require 'gosu/all'

require_relative 'lib/patterns'
require_relative 'lib/cell'
require_relative 'lib/world'

class GameOfLife < World
  def initialize(x = DEFAULT_X, y = DEFAUL_Y, speed = DEFAULT_SPEED, pattern = DEFAULT_PATTERN)
    super(x, y, speed, pattern)
  end
end

window = GameOfLife.new(64, 64, 0.5)
window.show
