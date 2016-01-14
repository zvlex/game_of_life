module GameOfLife
  class CellTable
    attr_accessor :column, :row

    def initialize(column, row)
      @column = column
      @row = row
    end
  end
end
