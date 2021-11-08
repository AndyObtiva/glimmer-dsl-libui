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
      subject.grid.cells[row].each_with_index do |cell, column|
        the_cell = cell
        expect(the_cell.grid).to eq(subject.grid)
        expect(the_cell.row).to eq(row)
        expect(the_cell.column).to eq(column)
        expect(the_cell.content).to be_nil
      end
    end
  end
  
  it 'starts game by generating snake head and apple in random cells' do
    expect(subject.snake).to be_nil
    expect(subject.apple).to be_nil
    subject.start
    
    expect(subject.snake).to be_a(Snake::Model::Snake)
    expect(subject.snake.cells.size).to eq(1)
    expect(subject.snake.cells.last).to be_a(Snake::Model::Cell)
    expect(subject.snake.cells.last.row).to be_between(0, subject.grid.height)
    expect(subject.snake.cells.last.column).to be_between(0, subject.grid.width)
    expect(subject.snake.turn_cells).to eq([])
    expect(Snake::Model::Snake::ORIENTATIONS).to include(subject.snake.orientation)
    expect(subject.snake.length).to eq(1)
    
    expect(subject.apple).to be_a(Snake::Model::Apple)
    expect(subject.apple.cell).to be_a(Snake::Model::Cell)
    expect(subject.snake.cells).to_not include(subject.apple.cell)
    expect(subject.apple.cell.row).to be_between(0, subject.grid.height)
    expect(subject.apple.cell.column).to be_between(0, subject.grid.width)
  end
  
  it 'moves snake of length 1 by one cell east without going through a wall' do
    subject.start
    
    subject.snake.generate(initial_cell: subject.grid.cells.first.first, initial_orientation: :east)
    expect(subject.snake.cells.last).to eq(subject.grid.cells.first.first)
    expect(subject.snake.orientation).to eq(:east)
    subject.apple.generate(initial_cell: subject.grid.cells[20][20])
    expect(subject.apple.cell).to eq(subject.grid.cells[20][20])
    
    subject.snake.move_by_one_cell
    
    expect(subject.grid.cells.first.first.content).to be_nil
    expect(subject.snake.cells.size).to eq(1)
    expect(subject.snake.cells.last).to eq(subject.grid.cells.first[1])
    expect(subject.snake.turn_cells).to be_empty
  end
  
  it 'moves snake of length 1 by one cell east going through a wall' do
    subject.start
    
    subject.snake.generate(initial_cell: subject.grid.cells.first.last, initial_orientation: :east)
    expect(subject.snake.cells.last).to eq(subject.grid.cells.first.last)
    expect(subject.snake.orientation).to eq(:east)
    subject.apple.generate(initial_cell: subject.grid.cells[20][20])
    expect(subject.apple.cell).to eq(subject.grid.cells[20][20])
    
    subject.snake.move_by_one_cell
    
    expect(subject.grid.cells.first.last.content).to be_nil
    expect(subject.snake.cells.size).to eq(1)
    expect(subject.snake.cells.last).to eq(subject.grid.cells.first.first)
    expect(subject.snake.turn_cells).to be_empty
  end
  
  it 'moves snake of length 1 by one cell west without going through a wall' do
    subject.start
    
    subject.snake.generate(initial_cell: subject.grid.cells.first.last, initial_orientation: :west)
    expect(subject.snake.cells.last).to eq(subject.grid.cells.first.last)
    expect(subject.snake.orientation).to eq(:west)
    subject.apple.generate(initial_cell: subject.grid.cells[20][20])
    expect(subject.apple.cell).to eq(subject.grid.cells[20][20])
    
    subject.snake.move_by_one_cell
    
    expect(subject.grid.cells.first.last.content).to be_nil
    expect(subject.snake.cells.size).to eq(1)
    expect(subject.snake.cells.last).to eq(subject.grid.cells.first[-2])
    expect(subject.snake.turn_cells).to be_empty
  end
  
  it 'moves snake of length 1 by one cell west going through a wall' do
    subject.start
    
    subject.snake.generate(initial_cell: subject.grid.cells.first.first, initial_orientation: :west)
    expect(subject.snake.cells.last).to eq(subject.grid.cells.first.first)
    expect(subject.snake.orientation).to eq(:west)
    subject.apple.generate(initial_cell: subject.grid.cells[20][20])
    expect(subject.apple.cell).to eq(subject.grid.cells[20][20])
    
    subject.snake.move_by_one_cell
    
    expect(subject.grid.cells.first.first.content).to be_nil
    expect(subject.snake.cells.size).to eq(1)
    expect(subject.snake.cells.last).to eq(subject.grid.cells.first.last)
    expect(subject.snake.turn_cells).to be_empty
  end
  
  it 'moves snake of length 1 by one cell south without going through a wall' do
    subject.start
    
    subject.snake.generate(initial_cell: subject.grid.cells.first.first, initial_orientation: :south)
    expect(subject.snake.cells.last).to eq(subject.grid.cells.first.first)
    expect(subject.snake.orientation).to eq(:south)
    subject.apple.generate(initial_cell: subject.grid.cells[20][20])
    expect(subject.apple.cell).to eq(subject.grid.cells[20][20])
    
    subject.snake.move_by_one_cell
    
    expect(subject.grid.cells.first.first.content).to be_nil
    expect(subject.snake.cells.size).to eq(1)
    expect(subject.snake.cells.last).to eq(subject.grid.cells[1].first)
    expect(subject.snake.turn_cells).to be_empty
  end
  
  it 'moves snake of length 1 by one cell south going through a wall' do
    subject.start
    
    subject.snake.generate(initial_cell: subject.grid.cells.last.first, initial_orientation: :south)
    expect(subject.snake.cells.last).to eq(subject.grid.cells.last.first)
    expect(subject.snake.orientation).to eq(:south)
    subject.apple.generate(initial_cell: subject.grid.cells[20][20])
    expect(subject.apple.cell).to eq(subject.grid.cells[20][20])
    
    subject.snake.move_by_one_cell
    
    expect(subject.grid.cells.first.last.content).to be_nil
    expect(subject.snake.cells.size).to eq(1)
    expect(subject.snake.cells.last).to eq(subject.grid.cells.first.first)
    expect(subject.snake.turn_cells).to be_empty
  end
  
  it 'moves snake of length 1 by one cell north without going through a wall' do
    subject.start
    
    subject.snake.generate(initial_cell: subject.grid.cells.last.first, initial_orientation: :north)
    expect(subject.snake.cells.last).to eq(subject.grid.cells.last.first)
    expect(subject.snake.orientation).to eq(:north)
    subject.apple.generate(initial_cell: subject.grid.cells[20][20])
    expect(subject.apple.cell).to eq(subject.grid.cells[20][20])
    
    subject.snake.move_by_one_cell
    
    expect(subject.grid.cells.first.first.content).to be_nil
    expect(subject.snake.cells.size).to eq(1)
    expect(subject.snake.cells.last).to eq(subject.grid.cells[-2].first)
    expect(subject.snake.turn_cells).to be_empty
  end
  
  it 'moves snake of length 1 by one cell north going through a wall' do
    subject.start
    
    subject.snake.generate(initial_cell: subject.grid.cells.first.first, initial_orientation: :north)
    expect(subject.snake.cells.last).to eq(subject.grid.cells.first.first)
    expect(subject.snake.orientation).to eq(:north)
    subject.apple.generate(initial_cell: subject.grid.cells[20][20])
    expect(subject.apple.cell).to eq(subject.grid.cells[20][20])
    
    subject.snake.move_by_one_cell
    
    expect(subject.grid.cells.first.last.content).to be_nil
    expect(subject.snake.cells.size).to eq(1)
    expect(subject.snake.cells.last).to eq(subject.grid.cells.last.first)
    expect(subject.snake.turn_cells).to be_empty
  end
end
