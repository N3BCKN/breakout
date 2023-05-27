require 'ruby2d'

WIDTH = 480
HEIGHT = 600

class Ball
  attr_accessor :x_velocity, :y_velocity
  attr_reader :x, :y 

  def initialize
    reset
  end 

  def draw
    Circle.new(x: @x, y: @y, radius: 5, color: 'white')
  end

  def move 
    @x += @x_velocity
    @y += @y_velocity

    @x_velocity *= -1 if hit_wall? 

    if hit_top?
      @x_velocity *= -1
      @y_velocity *= -1
    end 
  end

  def reset
    @x = WIDTH /  2
    @y = HEIGHT - HEIGHT / 2.5 
    @x_velocity = 0
    @y_velocity = 3
  end

  def hit_wall? 
    @x >= WIDTH || @x <= 0 
  end

  def hit_top?
    @y <= 0
  end

  def hit_bottom?
    @y >= HEIGHT
  end
end

class Paddle
  def initialize
    @x = WIDTH / 2 
    @y = HEIGHT - 10
  end 

  def move_left
    @x -= 9 unless @x - 9 <= 0 
  end 

  def move_right
    @x += 9 unless @x + 49 >= WIDTH 
  end

  def draw 
    Rectangle.new(x: @x, y: @y, width: 40, height: 10, color: 'red')
  end

  def mid_position
    @x + 20 
  end

  def hit_ball?(x,y)
    draw.contains?(x,y)
  end
end 

class Brick
  attr_reader :x, :y
  
  def initialize(x, y, color)
    @x = x 
    @y = y
    @color = color  
  end

  def draw
    Rectangle.new(x: @x, y: @y, width: 47 , height: 19, color: @color)
  end
end

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

    if brick.draw.contains?(ball.x, ball.y)
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
  if lifes > 0
    if event.key == 'left'
      player.move_left
    elsif event.key == 'right'
      player.move_right
    end
  end 
end 

show 
