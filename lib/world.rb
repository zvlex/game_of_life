class World < Gosu::Window
  include Patterns

  DEFAULT_PATTERN = 'flip_flop'
  DEFAULT_SPEED   = 0.5
  DEFAULT_STEPS   = 15
  DEFAULT_X       = 64
  DEFAULT_Y       = 64

  def initialize(x, y, speed, pattern)
    super(540, 320, false) # TODO:

    @x, @y, @speed = x, y, speed
    @generation = 0

    @grid = Gosu::Grid.new(self)
    @grid.default_cell = DeadCell.new(self, 0, 0)
    self.caption = "Game Of Life - Ruby implementation"

    @live = LiveCell.new(self)
    @dead = DeadCell.new(self)

    @world = Array.new(@x) do |row|
      Array.new(@y) do |column|
        @dead.update_attributes(row, column)
      end
    end

    prepare_cells!(pattern)
  end

  def live_neighbours(i, j)
    neighbours = []

    if @world.length > (i + 1) && @world[i].length > (j + 1)
      neighbours << @world[i - 1][j]
      neighbours << @world[i][j - 1]
      neighbours << @world[i][j + 1]
      neighbours << @world[i + 1][j]
      neighbours << @world[i + 1][j - 1]
      neighbours << @world[i + 1][j + 1]
      neighbours << @world[i - 1][j - 1]
      neighbours << @world[i - 1][j + 1]
    end

    neighbours.select! { |a| a.alive? }
    neighbours.size
  end

  def needs_cursor?; true; end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

  def prepare_cells!(pattern)
    if self.respond_to?(pattern)
      cells_list = self.send(pattern)

      cells_list.each do |x, y|
        @world[x][y] = LiveCell.new(self, x, y)
      end
    else
      raise "#{pattern} pattern does not exits"
    end
  end

  def update
    result  = []
    threads = []

    @world.each_with_index do |cells, i|
      cells.each_with_index do |k, j|
        threads << Thread.new do
          neighbours_quantity = live_neighbours(i, j)

          if @world[i][j].alive?

            if neighbours_quantity < 2 || neighbours_quantity > 3
              result << DeadCell.new(self, i, j)
            end
          else

            if neighbours_quantity == 3
              result << LiveCell.new(self, i, j)
            end
          end

        end
      end

      threads.map(&:join)
    end

    next_generation!(result)
    fill_cells!

    if @generation >= DEFAULT_STEPS
      puts "Just stop script after #{@generation} steps"
      exit
    else
      puts "ok - #{@generation}"
    end
  end

  def next_generation!(array)
    array.each do |cell|
      @world[cell.row][cell.column] = cell
    end

    @generation += 1
  end

  def fill_cells!
    @world.each do |arr|
      arr.each do |element|
        @grid.cells << element
      end
    end
  end

  def draw
    fill_cells!
    @grid.draw && sleep(@speed)
  end
end
