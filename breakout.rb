require 'ruby2d'

class Ball
end

class Paddle
  def initialize
    @x = 240
    @y = 590
  end 

  def move_left
    @x -= 7 unless @x - 7 <= 0 
  end 

  def move_right
    @x += 7 unless @x + 47 >= 480 
  end

  def draw 
    Rectangle.new(x: @x, y: @y, width: 40, height: 10, color: 'red')
  end
end 

class Brick
end


set width: 480
set height: 600
set title: 'breakout'

player = Paddle.new

update do
  clear 

  player.draw 
end

on :key_held do |event|
  if event.key == 'left'
    player.move_left
  elsif event.key == 'right'
    player.move_right
  end
end 

show 
