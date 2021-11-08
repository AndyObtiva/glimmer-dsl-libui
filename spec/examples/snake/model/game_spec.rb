require 'spec_helper'

require 'examples/snake/model/game'

RSpec.describe Snake::Model::Game do
  it 'has a grid of vertebrae of width of 40 and height of 40' do
    expect(subject).to be_a(Snake::Model::Game)
    expect(subject.width).to eq(40)
    expect(subject.height).to eq(40)
  end
  
  it 'starts game by generating snake and apple in random locations' do
    subject.start
    
    expect(subject).to_not be_over
    expect(subject.score).to eq(0)
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
  
  it 'moves snake of length 1 east without going through a wall' do
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
  
  it 'moves snake of length 1 east going through a wall' do
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
  
  it 'moves snake of length 1 west without going through a wall' do
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
  
  it 'moves snake of length 1 west going through a wall' do
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
  
  it 'moves snake of length 1 south without going through a wall' do
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
  
  it 'moves snake of length 1 south going through a wall' do
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
  
  it 'moves snake of length 1 north without going through a wall' do
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
  
  it 'moves snake of length 1 north going through a wall' do
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
  
  it 'starts snake going east, moves, turns right south, and moves south' do
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
  
  it 'starts snake going west, moves, turns right north, and moves south' do
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
  
  it 'starts snake going south, moves, turns right west, and moves south' do
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
  
  it 'starts snake going north, moves, turns right east, and moves south' do
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
  
  it 'starts snake going east, moves, turns left north, and moves south' do
    direction = :east
    subject.start
    
    subject.snake.generate(initial_row: 39, initial_column: 0, initial_orientation: direction)
    subject.apple.generate(initial_row: 20, initial_column: 20)
    
    new_direction = :north
    subject.snake.move
    subject.snake.turn_left
    expect(subject.snake.head.orientation).to eq(new_direction)
    subject.snake.move
    
    expect(subject.snake.length).to eq(1)
    expect(subject.snake.head.row).to eq(38)
    expect(subject.snake.head.column).to eq(1)
    expect(subject.snake.head.orientation).to eq(new_direction)
  end
  
  it 'starts snake going west, moves, turns left south, and moves south' do
    direction = :west
    subject.start
    
    subject.snake.generate(initial_row: 0, initial_column: 39, initial_orientation: direction)
    subject.apple.generate(initial_row: 20, initial_column: 20)
    
    new_direction = :south
    subject.snake.move
    subject.snake.turn_left
    expect(subject.snake.head.orientation).to eq(new_direction)
    subject.snake.move
    
    expect(subject.snake.length).to eq(1)
    expect(subject.snake.head.row).to eq(1)
    expect(subject.snake.head.column).to eq(38)
    expect(subject.snake.head.orientation).to eq(new_direction)
  end
  
  it 'starts snake going south, moves, turns left east, and moves south' do
    direction = :south
    subject.start
    
    subject.snake.generate(initial_row: 0, initial_column: 0, initial_orientation: direction)
    subject.apple.generate(initial_row: 20, initial_column: 20)
    
    new_direction = :east
    subject.snake.move
    subject.snake.turn_left
    expect(subject.snake.head.orientation).to eq(new_direction)
    subject.snake.move
    
    expect(subject.snake.length).to eq(1)
    expect(subject.snake.head.row).to eq(1)
    expect(subject.snake.head.column).to eq(1)
    expect(subject.snake.head.orientation).to eq(new_direction)
  end
  
  it 'starts snake going north, moves, turns left west, and moves south' do
    direction = :north
    subject.start
    
    subject.snake.generate(initial_row: 39, initial_column: 39, initial_orientation: direction)
    subject.apple.generate(initial_row: 20, initial_column: 20)
    
    new_direction = :west
    subject.snake.move
    subject.snake.turn_left
    expect(subject.snake.head.orientation).to eq(new_direction)
    subject.snake.move
    
    expect(subject.snake.length).to eq(1)
    expect(subject.snake.head.row).to eq(38)
    expect(subject.snake.head.column).to eq(38)
    expect(subject.snake.head.orientation).to eq(new_direction)
  end
  
  it 'starts snake going east, moves, turns right south, and eats apple while moving south' do
    direction = :east
    subject.start
    
    subject.snake.generate(initial_row: 0, initial_column: 0, initial_orientation: direction)
    subject.apple.generate(initial_row: 1, initial_column: 1)
    
    new_direction = :south
    subject.snake.move
    subject.snake.turn_right
    subject.snake.move
    
    expect(subject.snake.length).to eq(2)
    expect(subject.snake.vertebrae[0].row).to eq(0)
    expect(subject.snake.vertebrae[0].column).to eq(1)
    expect(subject.snake.vertebrae[0].orientation).to eq(new_direction)
    expect(subject.snake.vertebrae[1].row).to eq(1)
    expect(subject.snake.vertebrae[1].column).to eq(1)
    expect(subject.snake.vertebrae[1].orientation).to eq(new_direction)
  end
  
  it 'starts snake going east, moves, turns right south, eats apple while moving south, turns left, eats apple while moving east' do
    direction = :east
    subject.start
    
    subject.snake.generate(initial_row: 0, initial_column: 0, initial_orientation: direction)
    subject.apple.generate(initial_row: 1, initial_column: 1)
    
    subject.snake.move
    subject.snake.turn_right
    subject.snake.move # eats apple
    subject.apple.generate(initial_row: 1, initial_column: 2)
    subject.snake.turn_left
    subject.snake.move # eats apple
    
    expect(subject.snake.length).to eq(3)
    expect(subject.snake.vertebrae[0].row).to eq(0)
    expect(subject.snake.vertebrae[0].column).to eq(1)
    expect(subject.snake.vertebrae[0].orientation).to eq(:south)
    expect(subject.snake.vertebrae[1].row).to eq(1)
    expect(subject.snake.vertebrae[1].column).to eq(1)
    expect(subject.snake.vertebrae[1].orientation).to eq(:east)
    expect(subject.snake.vertebrae[2].row).to eq(1)
    expect(subject.snake.vertebrae[2].column).to eq(2)
    expect(subject.snake.vertebrae[2].orientation).to eq(:east)
  end
  
  it 'starts snake going east, moves, turns right south, eats apple while moving south, turns left, eats apple while moving east, turns right, moves south' do
    direction = :east
    subject.start
    
    subject.snake.generate(initial_row: 0, initial_column: 0, initial_orientation: direction)
    subject.apple.generate(initial_row: 1, initial_column: 1)
    
    subject.snake.move
    subject.snake.turn_right
    subject.snake.move # eats apple
    subject.apple.generate(initial_row: 1, initial_column: 2)
    subject.snake.turn_left
    subject.snake.move # eats apple
    subject.apple.generate(initial_row: 20, initial_column: 20)
    subject.snake.turn_right
    subject.snake.move
    
    expect(subject.snake.length).to eq(3)
    expect(subject.snake.vertebrae[0].row).to eq(1)
    expect(subject.snake.vertebrae[0].column).to eq(1)
    expect(subject.snake.vertebrae[0].orientation).to eq(:east)
    expect(subject.snake.vertebrae[1].row).to eq(1)
    expect(subject.snake.vertebrae[1].column).to eq(2)
    expect(subject.snake.vertebrae[1].orientation).to eq(:south)
    expect(subject.snake.vertebrae[2].row).to eq(2)
    expect(subject.snake.vertebrae[2].column).to eq(2)
    expect(subject.snake.vertebrae[2].orientation).to eq(:south)
  end
  
  it 'starts snake going east, moves, turns right south, eats apple while moving south, turns left, eats apple while moving east, turns left, eats apple while moving north, turns left, collides while moving west and game is over' do
    direction = :east
    subject.start
    
    subject.snake.generate(initial_row: 0, initial_column: 0, initial_orientation: direction)
    subject.apple.generate(initial_row: 1, initial_column: 1)
    
    subject.snake.move # 0, 1
    subject.snake.turn_right
    subject.snake.move # 1, 1 eats apple
    subject.apple.generate(initial_row: 1, initial_column: 2)
    subject.snake.turn_left
    subject.snake.move # 1, 2 eats apple
    subject.apple.generate(initial_row: 1, initial_column: 3)
    subject.snake.move # 1, 3 eats apple
    subject.apple.generate(initial_row: 1, initial_column: 4)
    subject.snake.move # 1, 4 eats apple
    subject.snake.turn_left
    subject.snake.move # 0, 4
    subject.snake.turn_left
    subject.snake.move # 0, 3
    subject.snake.turn_left
    subject.snake.move # 1, 3 (collision)
    
    expect(subject).to be_over
    expect(subject.score).to eq(50 * 4)
    expect(subject.snake).to be_collided
    expect(subject.snake.length).to eq(5)
    expect(subject.snake.vertebrae[0].row).to eq(1)
    expect(subject.snake.vertebrae[0].column).to eq(2)
    expect(subject.snake.vertebrae[0].orientation).to eq(:east)
    expect(subject.snake.vertebrae[1].row).to eq(1)
    expect(subject.snake.vertebrae[1].column).to eq(3)
    expect(subject.snake.vertebrae[1].orientation).to eq(:east)
    expect(subject.snake.vertebrae[2].row).to eq(1)
    expect(subject.snake.vertebrae[2].column).to eq(4)
    expect(subject.snake.vertebrae[2].orientation).to eq(:north)
    expect(subject.snake.vertebrae[3].row).to eq(0)
    expect(subject.snake.vertebrae[3].column).to eq(4)
    expect(subject.snake.vertebrae[3].orientation).to eq(:west)
    expect(subject.snake.vertebrae[4].row).to eq(0)
    expect(subject.snake.vertebrae[4].column).to eq(3)
    expect(subject.snake.vertebrae[4].orientation).to eq(:south)
  end
end
