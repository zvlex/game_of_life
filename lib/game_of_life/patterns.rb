module GameOfLife
  module Patterns
    def glider
      [ [1, 3], [2, 3], [3, 3], [2, 1], [3, 2] ]
    end

    def blinker
      [ [3, 1], [3, 2], [3, 3] ]
    end

    def flip_flop
      [ [3, 4], [4, 3], [4, 4], [4, 5] ]
    end
  end
end
