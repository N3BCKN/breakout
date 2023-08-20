require 'ruby2d'

require './lib/paddle'
require './lib/ball'
require './lib/brick'

WIDTH = 480
HEIGHT = 600

set width: WIDTH
set height: HEIGHT
set title: 'breakout'

player = Paddle.new
ball = Ball.new
score = 0 
lifes = 4
bricks = []

def draw_score(score)
  Text.new(score, x: 30, y: 30, size: 30, color: 'white')
end 

8.times do |i|
  if (0..1).include? i
    color = 'yellow'
  elsif (2..3).include? i
    color = 'green'
  elsif (4..5).include? i
    color = 'orange'
  elsif (6..7).include? i
    color = 'red'
  end

  (0..WIDTH).step(48).each do |x|
    brick = Brick.new(x, HEIGHT/2.5 - i * 20, color)
    bricks << brick 
  end
end

update do
  clear 

  ball.draw
  player.draw 
  draw_score(score)

  bricks.each_with_index do |brick, index|
    brick.draw

    if brick.shape.contains?(ball.x, ball.y)
      bricks = bricks.reject.with_index{|_, i| i == index }
      
      score += 10 
      ball.y_velocity *= -1
    end
  end

  if lifes == 0
    Text.new('Game Over', x: WIDTH/2 - 160, y: HEIGHT/2, size: 60, color: 'red')
    next
  elsif bricks.size == 0
    Text.new('You won!', x: WIDTH/2 - 130, y: HEIGHT/4, size: 60, color: 'green')
    next
  end 

  ball.move

  if player.hit_ball?(ball.x, ball.y)
    ball.y_velocity *= -1
    ball.x_velocity = (ball.x - player.mid_position) * 0.15
  end

  if ball.hit_bottom?
    ball.reset
    lifes -= 1
  end
end

on :key_held do |event|
  if lifes > 0 || bricks.size == 0
    if event.key == 'left'
      player.move_left
    elsif event.key == 'right'
      player.move_right
    end
  end 
end 

show 
