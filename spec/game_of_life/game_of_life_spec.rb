require 'spec_helper'

describe GameOfLife do
  let(:game) { GameOfLife::GameWorld.new('flip_flop') }

  it 'fills cells' do
    game.fill_cells!
    expect(game.grid.cells).not_to be_empty
  end

  it 'counts generations' do
    game.next_generation!
    expect(game.generation).not_to eq(0)
  end

  it 'sets cell table column and row' do
    expect(game.world).not_to be_empty
  end

  it 'counts live neighbours quantity' do
    result = []

    game.flip_flop.each do |pattern|
      row, col = pattern

      result << game.live_neighbours_quantity(row, col)
    end

    expect(result).to include(2, 3)
  end

  it 'finds live cells which was prepared after initialize' do
    result = []

    game.world.each do |cells|
       cells.each do |cell|
         result << cell if cell.alive?
       end
    end

    expect(result).not_to be_empty
  end
end
