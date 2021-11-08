require 'spec_helper'

require 'examples/snake/model/game'

RSpec.describe Snake::Model::Game do
  it 'has a grid of vertebrae of width of 40 and height of 40' do
    expect(subject).to be_a(Snake::Model::Game)
    expect(subject.width).to eq(40)
    expect(subject.height).to eq(40)
  end
  
  it 'starts game by generating snake and apple in random locations' do
    expect(subject.snake).to be_nil
    expect(subject.apple).to be_nil
    subject.start
    
    expect(subject.snake).to be_a(Snake::Model::Snake)
    expect(subject.snake.length).to eq(1)
    expect(subject.snake.head).to be_a(Snake::Model::Vertebra)
    expect(subject.snake.head).to eq(subject.snake.vertebrae.last)
    expect(subject.snake.head.row).to be_between(0, subject.height)
    expect(subject.snake.head.column).to be_between(0, subject.width)
    expect(Snake::Model::Vertebra::ORIENTATIONS).to include(subject.snake.head.orientation)
    expect(subject.snake.length).to eq(1)
    
    expect(subject.apple).to be_a(Snake::Model::Apple)
    expect(subject.snake.vertebrae.map {|v| [v.row, v.column]}).to_not include([subject.apple.row, subject.apple.column])
    expect(subject.apple.row).to be_between(0, subject.height)
    expect(subject.apple.column).to be_between(0, subject.width)
  end
  
  it 'moves snake of length 1 by one cell east without going through a wall' do
    direction = :east
    subject.start
    
    subject.snake.generate(initial_row: 0, initial_column: 0, initial_orientation: direction)
    expect(subject.snake.head.row).to eq(0)
    expect(subject.snake.head.column).to eq(0)
    expect(subject.snake.head.orientation).to eq(direction)
    subject.apple.generate(initial_row: 20, initial_column: 20)
    expect(subject.apple.row).to eq(20)
    expect(subject.apple.column).to eq(20)
    
    subject.snake.move
    
    expect(subject.snake.length).to eq(1)
    expect(subject.snake.head.row).to eq(0)
    expect(subject.snake.head.column).to eq(1)
  end
  
  it 'moves snake of length 1 by one cell east going through a wall' do
    direction = :east
    subject.start
    
    subject.snake.generate(initial_row: 0, initial_column: 39, initial_orientation: direction)
    expect(subject.snake.head.row).to eq(0)
    expect(subject.snake.head.column).to eq(39)
    expect(subject.snake.head.orientation).to eq(direction)
    subject.apple.generate(initial_row: 20, initial_column: 20)
    expect(subject.apple.row).to eq(20)
    expect(subject.apple.column).to eq(20)
    
    subject.snake.move
    
    expect(subject.snake.length).to eq(1)
    expect(subject.snake.head.row).to eq(0)
    expect(subject.snake.head.column).to eq(0)
  end
  
  it 'moves snake of length 1 by one cell west without going through a wall' do
    direction = :west
    subject.start
    
    subject.snake.generate(initial_row: 0, initial_column: 39, initial_orientation: direction)
    expect(subject.snake.head.row).to eq(0)
    expect(subject.snake.head.column).to eq(39)
    expect(subject.snake.head.orientation).to eq(direction)
    subject.apple.generate(initial_row: 20, initial_column: 20)
    expect(subject.apple.row).to eq(20)
    expect(subject.apple.column).to eq(20)
    
    subject.snake.move
    
    expect(subject.snake.length).to eq(1)
    expect(subject.snake.head.row).to eq(0)
    expect(subject.snake.head.column).to eq(38)
  end
  
  it 'moves snake of length 1 by one cell west going through a wall' do
    direction = :west
    subject.start
    
    subject.snake.generate(initial_row: 0, initial_column: 0, initial_orientation: direction)
    expect(subject.snake.head.row).to eq(0)
    expect(subject.snake.head.column).to eq(0)
    expect(subject.snake.head.orientation).to eq(direction)
    subject.apple.generate(initial_row: 20, initial_column: 20)
    expect(subject.apple.row).to eq(20)
    expect(subject.apple.column).to eq(20)
    
    subject.snake.move
    
    expect(subject.snake.length).to eq(1)
    expect(subject.snake.head.row).to eq(0)
    expect(subject.snake.head.column).to eq(39)
  end
  
  it 'moves snake of length 1 by one cell south without going through a wall' do
    direction = :south
    subject.start
    
    subject.snake.generate(initial_row: 0, initial_column: 0, initial_orientation: direction)
    expect(subject.snake.head.row).to eq(0)
    expect(subject.snake.head.column).to eq(0)
    expect(subject.snake.head.orientation).to eq(direction)
    subject.apple.generate(initial_row: 20, initial_column: 20)
    expect(subject.apple.row).to eq(20)
    expect(subject.apple.column).to eq(20)
    
    subject.snake.move
    
    expect(subject.snake.length).to eq(1)
    expect(subject.snake.head.row).to eq(1)
    expect(subject.snake.head.column).to eq(0)
  end
  
  it 'moves snake of length 1 by one cell south going through a wall' do
    direction = :south
    subject.start
    
    subject.snake.generate(initial_row: 39, initial_column: 0, initial_orientation: direction)
    expect(subject.snake.head.row).to eq(39)
    expect(subject.snake.head.column).to eq(0)
    expect(subject.snake.head.orientation).to eq(direction)
    subject.apple.generate(initial_row: 20, initial_column: 20)
    expect(subject.apple.row).to eq(20)
    expect(subject.apple.column).to eq(20)
    
    subject.snake.move
    
    expect(subject.snake.length).to eq(1)
    expect(subject.snake.head.row).to eq(0)
    expect(subject.snake.head.column).to eq(0)
  end
  
  it 'moves snake of length 1 by one cell north without going through a wall' do
    direction = :north
    subject.start
    
    subject.snake.generate(initial_row: 39, initial_column: 0, initial_orientation: direction)
    expect(subject.snake.head.row).to eq(39)
    expect(subject.snake.head.column).to eq(0)
    expect(subject.snake.head.orientation).to eq(direction)
    subject.apple.generate(initial_row: 20, initial_column: 20)
    expect(subject.apple.row).to eq(20)
    expect(subject.apple.column).to eq(20)
    
    subject.snake.move
    
    expect(subject.snake.length).to eq(1)
    expect(subject.snake.head.row).to eq(38)
    expect(subject.snake.head.column).to eq(0)
  end
  
  it 'moves snake of length 1 by one cell north going through a wall' do
    direction = :north
    subject.start
    
    subject.snake.generate(initial_row: 0, initial_column: 0, initial_orientation: direction)
    expect(subject.snake.head.row).to eq(0)
    expect(subject.snake.head.column).to eq(0)
    expect(subject.snake.head.orientation).to eq(direction)
    subject.apple.generate(initial_row: 20, initial_column: 20)
    expect(subject.apple.row).to eq(20)
    expect(subject.apple.column).to eq(20)
    
    subject.snake.move
    
    expect(subject.snake.length).to eq(1)
    expect(subject.snake.head.row).to eq(39)
    expect(subject.snake.head.column).to eq(0)
  end
  
  it 'starts snake going east, moves by one cell, turns right south, and moves by one cell south' do
    direction = :east
    subject.start
    
    subject.snake.generate(initial_row: 0, initial_column: 0, initial_orientation: direction)
    subject.apple.generate(initial_row: 20, initial_column: 20)
    
    new_direction = :south
    subject.snake.move
    subject.snake.turn_right
    expect(subject.snake.head.orientation).to eq(new_direction)
    subject.snake.move
    
    expect(subject.snake.length).to eq(1)
    expect(subject.snake.head.row).to eq(1)
    expect(subject.snake.head.column).to eq(1)
    expect(subject.snake.head.orientation).to eq(new_direction)
  end
  
  it 'starts snake going east, moves by one cell, turns right south, and moves by one cell south' do
    direction = :west
    subject.start
    
    subject.snake.generate(initial_row: 39, initial_column: 39, initial_orientation: direction)
    subject.apple.generate(initial_row: 20, initial_column: 20)
    
    new_direction = :north
    subject.snake.move
    subject.snake.turn_right
    expect(subject.snake.head.orientation).to eq(new_direction)
    subject.snake.move
    
    expect(subject.snake.length).to eq(1)
    expect(subject.snake.head.row).to eq(38)
    expect(subject.snake.head.column).to eq(38)
    expect(subject.snake.head.orientation).to eq(new_direction)
  end
  
  it 'starts snake going east, moves by one cell, turns right south, and moves by one cell south' do
    direction = :south
    subject.start
    
    subject.snake.generate(initial_row: 0, initial_column: 39, initial_orientation: direction)
    subject.apple.generate(initial_row: 20, initial_column: 20)
    
    new_direction = :west
    subject.snake.move
    subject.snake.turn_right
    expect(subject.snake.head.orientation).to eq(new_direction)
    subject.snake.move
    
    expect(subject.snake.length).to eq(1)
    expect(subject.snake.head.row).to eq(1)
    expect(subject.snake.head.column).to eq(38)
    expect(subject.snake.head.orientation).to eq(new_direction)
  end
  
  it 'starts snake going east, moves by one cell, turns right south, and moves by one cell south' do
    direction = :north
    subject.start
    
    subject.snake.generate(initial_row: 39, initial_column: 0, initial_orientation: direction)
    subject.apple.generate(initial_row: 20, initial_column: 20)
    
    new_direction = :east
    subject.snake.move
    subject.snake.turn_right
    expect(subject.snake.head.orientation).to eq(new_direction)
    subject.snake.move
    
    expect(subject.snake.length).to eq(1)
    expect(subject.snake.head.row).to eq(38)
    expect(subject.snake.head.column).to eq(1)
    expect(subject.snake.head.orientation).to eq(new_direction)
  end
  
  xit 'starts snake going east, moves by one cell, turns right south, and eats apple while moving by one cell south' do
    subject.start
    
    subject.snake.generate(initial_cell: subject.vertebrae.first.first, initial_orientation: :east)
    subject.apple.generate(initial_cell: subject.vertebrae[1][1])
    
    subject.snake.turn_right
    
    expect(subject.snake.head.orientation).to eq(:south)
    
    subject.snake.move
    expect(subject.snake.vertebrae.size).to eq(2)
    expect(subject.snake.head).to eq(subject.vertebrae[1].first)
    expect(subject.snake.head.orientation).to eq(:south)
  end
end
