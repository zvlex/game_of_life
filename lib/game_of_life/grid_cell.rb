module GameOfLife
  class GridCell < Gosu::Grid::Cell
    attr_accessor :object, :cell_table

    CELL_IMAGES = {
      'GameOfLife::LiveGridCell': 'live.png',
      'GameOfLife::DeadGridCell': 'dead.png'
    }

    def initialize(obj, cell_table)
      @cell_table = cell_table

      super(obj, cell_table.column, cell_table.row)
      load_cell_image
    end

    def set_cell_table(row, column)
      cell_table.row = row
      cell_table.column = column

      self
    end

    def alive?
      is_a?(LiveGridCell)
    end

    def size
      object.width
    end

    def load_cell_image
      image_path = "./lib/game_of_life/images/#{CELL_IMAGES[self.class.name.to_sym]}"

      @object = Gosu::Image.new(window, image_path, true)
    end
  end

  class LiveGridCell < GridCell
    def initialize(obj, cell_table)
      super(obj, cell_table)
    end
  end

  class DeadGridCell < GridCell
    def initialize(obj, cell_table)
      super(obj, cell_table)
    end
  end
end
