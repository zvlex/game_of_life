module GameOfLife
  class GameWorld < Gosu::Window
    include Patterns

    DEFAULT_PATTERN = 'flip_flop'
    DEFAULT_SPEED   = 0.5
    DEFAULT_STEPS   = 15
    DEFAULT_X       = 64
    DEFAULT_Y       = 64

    attr_reader :grid
    attr_accessor :world, :cell_table, :result, :generation, :pattern

    def initialize(pattern = DEFAULT_PATTERN)
      super(540, 320, false)

      self.caption = 'Game Of Life - Ruby implementation'

      @result = []
      @pattern = pattern
      @generation = 0

      @cell_table = CellTable.new(0, 0)

      @grid = Gosu::Grid.new(self)
      @dead = DeadGridCell.new(self, cell_table)
      @grid.default_cell = @dead

      @world = Array.new(DEFAULT_X) do |row|
        Array.new(DEFAULT_Y) do |column|
          @dead.set_cell_table(column, row)
        end
      end

      prepare_live_cells!
    end

    def live_neighbours_quantity(i, j)
      neighbours = []

      if available_world_length(world, i, j)
        neighbours << world[i - 1][j]
        neighbours << world[i][j - 1]
        neighbours << world[i][j + 1]
        neighbours << world[i + 1][j]
        neighbours << world[i + 1][j - 1]
        neighbours << world[i + 1][j + 1]
        neighbours << world[i - 1][j - 1]
        neighbours << world[i - 1][j + 1]
      end

      neighbours.select!(&:alive?)
      neighbours.size
    end

    def available_world_length(world, i, j)
      world.length > (i + 1) && world[i].length > (j + 1)
    end

    def needs_cursor?
      true
    end

    def button_down(id)
      close if id == Gosu::KbEscape
    end

    def prepare_live_cells!
      if self.respond_to?(pattern)
        cells_list = send(pattern)

        cells_list.each do |row, column|
          world[row][column] = LiveGridCell.new(self, CellTable.new(row, column))
        end
      else
        fail "#{pattern} pattern does not exits"
      end
    end

    def calculate_neighbours(world, row, column)
      neighbours_quantity = live_neighbours_quantity(row, column)

      if world[row][column].alive?

        if neighbours_quantity < 2 || neighbours_quantity > 3
          result << DeadGridCell.new(self, CellTable.new(row, column))
        end
      else

        if neighbours_quantity == 3
          result << LiveGridCell.new(self, CellTable.new(row, column))
        end
      end
    end

  def update
    threads = []

    world.each_with_index do |cells, row|
      cells.each_with_index do |k, column|
        threads << Thread.new do
          calculate_neighbours(world, row, column)
        end
      end

      threads.map(&:join)
    end

    next_generation!
    fill_cells!
    show_output_logs
  end

    def show_output_logs
      if @generation >= DEFAULT_STEPS
        puts "Just stop script after #{@generation} steps..."
        exit
      else
        puts "Ok - Step: #{@generation}"
      end
    end

    def next_generation!
      result.each do |cell|
        world[cell.row][cell.column] = cell
      end

      @generation += 1
    end

    def fill_cells!
      world.each do |arr|
        arr.each do |element|
          grid.cells << element
        end
      end
    end

    def draw
      fill_cells!
      grid.draw && sleep(DEFAULT_SPEED)
    end
  end
end
