class Cell < Gosu::Grid::Cell
  attr_accessor :alive, :object

  CELL_IMAGES = {
    LiveCell: 'live.png',
    DeadCell: 'dead.png'
  }

  def initialize(obj, column = 0, row = 0, alive)
    super(obj, column, row)

    @alive = alive
    load_cell_image
  end

  def alive?; self.alive; end

  def size
    object.width
  end

  def update_attributes(row, column)
    self.row, self.column = row, column
    self
  end

  def load_cell_image
    image_path = "./images/#{CELL_IMAGES[self.class.name.to_sym]}"
    @object = Gosu::Image.new(window, image_path, true)
  end
end

class LiveCell < Cell
  def initialize(obj, column = 0, row = 0)
    super(obj, column, row, true)
  end
end

class DeadCell < Cell
  def initialize(obj, column = 0, row = 0)
    super(obj, column, row, false)
  end
end
