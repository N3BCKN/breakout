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
    Circle.new(x: @x, y: @y, radius: 5, color: 'blue')
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
    @y = HEIGHT - HEIGHT / 3 
    @x_velocity = rand(3..5)
    @y_velocity = rand(2..4)
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
    @x -= 7 unless @x - 7 <= 0 
  end 

  def move_right
    @x += 7 unless @x + 47 >= WIDTH 
  end

  def draw 
    Rectangle.new(x: @x, y: @y, width: 40, height: 10, color: 'red')
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
lifes = 3
bricks = []

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
  ball.move

  bricks.each_with_index do |brick, index|
    brick.draw

    if brick.draw.contains?(ball.x, ball.y)
      bricks = bricks.reject.with_index{|_, i| i == index }
      
      score += 1 
      ball.x_velocity *= -1
      ball.y_velocity *= -1
    end
  end

  if player.hit_ball?(ball.x, ball.y)
    ball.x_velocity *= -1
    ball.y_velocity *= -1
  end

  if ball.hit_bottom?
    ball.reset
  end

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
