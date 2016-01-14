require 'gosu'
require 'gosu/all'

require 'game_of_life/patterns'
require 'game_of_life/game_world'
require 'game_of_life/cell_table'
require 'game_of_life/grid_cell'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end
