require 'spec_helper'

require 'examples/snake/model/game'

RSpec.describe 'Snake' do
  subject do
    Snake::Model::Game.new
  end
  
  it 'has a grid of cells of width of 40 and height of 40' do
    expect(subject.grid).to be_a(Snake::Model::Grid)
    expect(subject.grid.width).to eq(40)
    expect(subject.grid.height).to eq(40)
    expect(subject.grid.cells).to be_a(Array)
    expect(subject.grid.cells.size).to eq(40)
    expect(subject.grid.cells.map(&:size).uniq).to eq([40])
    subject.grid.cells.each_with_index do |row_cells, row|
      subject.grid.cells[row].each_with_index do |column_cells, column|
        the_cell = subject.grid.cells[row][column]
        expect(the_cell.grid).to eq(subject.grid)
        expect(the_cell.row).to eq(row)
        expect(the_cell.column).to eq(column)
        expect(the_cell.content).to be_nil
      end
    end
  end
  
  xit 'generates snake head and apple in random cells on start' do
    expect(subject.snake).to be_nil
    expect(subject.apple).to be_nil
    subject.start
    
    expect(subject.snake).to_not be_nil
#     expect(subject.snake.head_cell.x).to be_greater_than
    expect(subject.apple).to_not be_nil
  end
end
